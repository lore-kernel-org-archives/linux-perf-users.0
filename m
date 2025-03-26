Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC21F7561;
	Wed, 26 Mar 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013310; cv=none; b=hZ3F03S6lDUXAIDn0ZyqDr03aWargiK51A1hiRmSIKV2pRs6Z4IZjnJNGeWDHXG9nsjrIwuxEwoXRHXOYp+AF3k5pwMdYhcdr3cO54XgwFDVY5x3EC65S3c4zftRDcqxLWZGrcXbyP8+5wdlHtvj/mAMzCWuscsV1WTDqcoXu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013310; c=relaxed/simple;
	bh=KzXSavSeEQvSYOYQr3q8Tb6HTNl/rJqVxIkNxLAVrV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+MMgrR5byfp7BoyRksbkkduvlbSTkevXGtNxT+ShzUInXOSh4P79+25yhvNtLPNBvSlKUOHSo6g9Otj9QxrSv8zwn0jblmno54pS2jkomZivqRfnE3YioWbHZP235t7ipQGm5zNcpEuKr91azzZ3WcDp6eRRICOWOXX+WtP+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBlAVG0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBlAVG0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A2C4CEE2;
	Wed, 26 Mar 2025 18:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743013309;
	bh=KzXSavSeEQvSYOYQr3q8Tb6HTNl/rJqVxIkNxLAVrV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBlAVG0wBZM7HF9+mEoNEcVtcrgGer1vv+lAbs+H57fQy+LRHpt9LGCB1h5UrrB3t
	 fVNF+hyWjEo7LBywTU7CSmfv660NbadZllILZgr6ghpdRF3lybdO25La4elmQirge6
	 iTy7AtT4j043KvIs9VfUGcMMJb5iHZpiKuSFOljQHHkIiMURhCoi58/SOO/feoj0FH
	 G3wygWD5pjaqdTqwIXcUPCZx7NsAou+eIeBHUL7Qg99reIe/TR831/lRXxleRW0oZ0
	 NRrk3rZRicbA8ljqs/+mbKdghedRT9T6pttbWK3tFtTiFTxg4+iG6q0mnIkEIWxLAa
	 7wwP+/aZnvDAA==
Date: Wed, 26 Mar 2025 11:21:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix possible insufficient allocation of
 argument formats
Message-ID: <Z-RFu_PLmKMq8YFU@google.com>
References: <20250324235245.613063-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324235245.613063-1-howardchu95@gmail.com>

On Mon, Mar 24, 2025 at 04:52:45PM -0700, Howard Chu wrote:
> In my previous fix of runtime error(Link:
> https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
> I made a mistake of decrementing one unconditionally, regardless of
> whether an extra 'syscall_nr' or 'nr' field was present in
> libtraceevent's tp_format. This may cause perf trace to allocate one
> fewer arg_fmt entry than needed for the accurate representation of syscall
> arguments.
> 
> This patch corrects the mistake by checking the presence of'syscall_nr' or
> 'nr', and adjusting the length of arg_fmt[] accordingly.

Thanks for the fix.  I've noticed this too but I feel like we can make
syscall__alloc_arg_fmts() a bit simpler.

How about this?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ac51925ea4249c2..b9bdab52f5801c3a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
-	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
-		nr_args = sc->fmt->nr_args;
-
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
@@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 			sc->arg_fmt[idx] = sc->fmt->arg[idx];
 	}
 
-	sc->nr_args = nr_args;
 	return 0;
 }
 
@@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
-	/*
-	 * The tracepoint format contains __syscall_nr field, so it's one more
-	 * than the actual number of syscall arguments.
-	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
-		return -ENOMEM;
-
 	sc->args = sc->tp_format->format.fields;
+	sc->nr_args = sc->tp_format->format.nr_fields;
+
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
@@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		--sc->nr_args;
 	}
 
+	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
+		return -ENOMEM;
+
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-- 
2.49.0.395.g12beb8f557-goog

