Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3203394E8A
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620884; cv=none; b=qHnGoS9qSHwB2AOtz3u7yYVY+9P7wutesN2MhO0KvD731XlDSuYueIxsQtZkVOyjjrC1ebbCsMg/SWWHhhqZU/eUBr6v+FvJIH7xHBleZv0DVUe8medSsdiSJNzzup3cyh1GsUqDL29vSaDr7o/9yJem0L4MFlBv5Fagd8CJ8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620884; c=relaxed/simple;
	bh=z16VV69o+gdZMIPYbKDfmRCC4bduOz3waFrPgF8Rtg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJc/kt8+EwnrRR/4sUYrqcNbx7pjjCAnVEljKLo9jUmGPTZLD2Zweyi9AQqBwKv61yot8Ywtsml1nxJeJ7hYVlMGIwK2aJRzB1Q4qcY4LLB6Q+0GGtXYDYB06T2WztCyBpkL6UXV42wZrK4KyfC/yc62P8oVbje2ZnznwI6L9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEma4tej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEma4tej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7353D1F000FF;
	Mon, 28 Sep 2026 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620882;
	bh=z16VV69o+gdZMIPYbKDfmRCC4bduOz3waFrPgF8Rtg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEma4tej3eSHaKFMvm31DkLTT8lhjTCQ38g3VuKJ1+s3NyuCXAZ1rUROVKs/ls1ti
	 dhTF//aUoXtGm2CrDFNH12yb/RJfH0ly/dGZwEyfXgw4suh64buDm3JYsH6E42Sr5t
	 6YoxQMpxUBLisifrpMOgqIjCHJX5Qz+TI30Qh+raVp7fEph7EnhzvXiL0v0QnJntUh
	 ncVMh0w4wRSVA2i1AbxjsSwSIvp/Pr7nmijqo4+ZK48ZdZGfx3jVIwuGAtuYJB5vPg
	 SkcgkbrewPTzdCTx9ema+B1zfNlDKExjDv3wapRLHh4M7RZPIw6DmEql61PDi2/Ked
	 KqE3PoCID/7Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/26] perf trace: Set the augmented arg header in
 the augmenters that omit it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-2-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:41:22 +0000
Message-Id: <20260928184122.7353D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The augmenters build records in augmented_args_tmp, a per-CPU scratch
> buffer reused by every syscall, so a header field that isn't written
> holds a stale value from an earlier syscall. sys_enter_sendto(),
> sys_enter_perf_event_open(), sys_enter_clock_nanosleep() and
> sys_enter_nanosleep() never set the struct augmented_arg size and err,
> and augment_arg() doesn't set err.
>=20
> Set both. When bpf_probe_read_user() fails in the connect, sendto and
> nanosleep augmenters, report a zero sized payload and the error rather
> than the stale scratch contents.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D1

