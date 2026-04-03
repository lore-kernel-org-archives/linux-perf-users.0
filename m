Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FC2765D7;
	Fri,  3 Apr 2026 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184146; cv=none; b=Dx8k0fbI5cFG3hZTOhQZaFMdSGhssyYA5qAqkVQfs+nR27IWTEq3BU0Zck3KSfZSZkrjKpvmKQgKlqWPnSZt8hbl2dpQm8ezRnsDY/1fAx3cG313Mp2Rf44g7zxmRqGB66CI24tdhKtGTnkl/ILlbyCwRqmg/BJZj4nn5vb8R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184146; c=relaxed/simple;
	bh=bEt6923MfGZEPfPIECL9O0QggtDqdLIMKM6x01sodvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBeuSuynAUo8PH6MOb9tBBsn0zOhWz06w5zLIiYaDFZmUfF2N9hPlAstQ9n76//M6Txcovp0riVgnjsp7tTopuxCQeZlSA257WC1BAKATRWT+8kJrb9VOw77gD/83Dp+ig/OvjBGXcnVV60FpnU5ZqC1E9u/aN30TbTu8EgUceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBqO2PfV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBqO2PfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5EAC116C6;
	Fri,  3 Apr 2026 02:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775184146;
	bh=bEt6923MfGZEPfPIECL9O0QggtDqdLIMKM6x01sodvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBqO2PfVNs4iQ2jWz01UDtiI8N/B1rFE1JtSfdHE6hfIUWqRNMt625D8+ctPgxiOc
	 JuJt+7shojjBmvZqZ27Bi6vc3Kg4KKdxLlN7Hr72bRJp4AD1+dXK0gUiEjbG9sZQwi
	 Oi5LRcmtALZAxrpVAqDhitgyZyRVhUtRd8X4+MD7dEscJ8c95foLnxoOgXL/2IGzA2
	 kPp0TycCe/relrbQPnKyd+QRwpiwbYguvxnIs5JHvnHs2ROOfU3Iu/0MABFfLkBHfY
	 FfjG9MQDAvki39lTT464pjwJw5wwFgaXI1pV7LR7vpM5FjHxR3u8zVyP56IBYq18mt
	 aq8xzSm3zeShQ==
Date: Thu, 2 Apr 2026 19:42:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <ac8pEDUKjuMxXUS6@google.com>
References: <20260321061448.810525-1-irogers@google.com>
 <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>

On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> On Thu, Mar 26, 2026 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > Doing a `perf sched record` then `perf sched stats report` crashes as
> > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > before accessing through it.
> >
> > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > for `perf sched stats report`.
> 
> Perhaps. I'd prefer to land the simpler change as-is.

Well.. I guess the dummy handler approach would be simpler and perform
better. :)

Thanks,
Namhyung


diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d083e2bb770303a4..9fb5447f9014d026 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
                .switch_event       = replay_switch_event,
                .fork_event         = replay_fork_event,
        };
+       struct trace_sched_handler stats_ops  = {};
        int ret;
 
        perf_tool__init(&sched.tool, /*ordered_events=*/true);
@@ -5037,6 +5038,7 @@ int cmd_sched(int argc, const char **argv)
        } else if (!strcmp(argv[0], "stats")) {
                const char *const stats_subcommands[] = {"record", "report", NULL};
 
+               sched.tp_handler = &stats_ops;
                argc = parse_options_subcommand(argc, argv, stats_options,
                                                stats_subcommands,
                                                stats_usage,

