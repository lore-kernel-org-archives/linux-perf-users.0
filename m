Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952991;
	b=T1E/SW0o6YFBZhxVilzEbbNFvzPCp5mE4ojTujjqVawA+wJ7jK2zH5vbuziBeMu1fn5c
	 SuTVcV3Ha5PMokLtfIwTLTRbqFpajrYTTyXB3cO9eH9booddE9a0ZbgiFZYOs+zvthRWt
	 DKpipblgxXiCQZ/m9Gk46Q6eW7gwA6jtSUDsGoLRABDsBhSLIZ8FMLYSCbANpahTYmp6X
	 wEH0nyAMK7QzozvZA37XWkZ7Ng2tZF6xDBrELAB2RhRyskIKNOWVFfwi2NZKTwG7yvFKT
	 mElZNDhgYNHlyQcMO1Ei2fD169S7Y7yjS+0L9j75oDRqZcnIvGL1Iz5dPbc2uk2JzXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/1g1RvakKpXfTQfajgYeyvYFpgNj5zqyZxADhonaCsg=;
	b=tNkeJbykJ7gMG/AIQ+UVHnSfy60HOpG01Y+YVUHjZCmHlz4PoDuRLY1lD6+OWLRDMeoM
	 KNdN49ZOo6WPfRBsSWJlx6Dhrx2s0cbibgHxDFRif/3TECZFwEQBPHhQLpAqYp3iFoq4T
	 nSdgPC/TYNgPpFgazLP2K7rPkBtQ4RXErMcbVs0lhy0e1Wq4PlMEeXtE4k3fSx7MXsvzl
	 ia+vVr2lQDzZlaTpzhxc2DADwAriXVGltLH0dovt21Y9GTX9OsYMmMT9KQVLpagf+nS2b
	 H+ghMLhNNwSlTXOYfHdiXbsdE9LJM1npF10ZnuszWwHy4jhfeC+KNOy/cLv3c6T7xYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKeMcrSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB69606A32F
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKeMcrSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066FB1F01829;
	Sun, 25 Oct 2026 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952991;
	bh=/1g1RvakKpXfTQfajgYeyvYFpgNj5zqyZxADhonaCsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dKeMcrSyTCrfnkjdjftGxVm9HeSGeqj+wUhEDeKyUVC6GmralCu8XBCdySbHK1odU
	 FIqmLzWXFMPjX1nVWJdhwcipnfZJE89T9vjPWJVAuD2b+LboCvajvkOp1YgBwrsOhp
	 YRltER4T1a/2MroL194dFJMEmxPwgZHfLNFpFurITz01Pil6NVYT6tvSRzsNfa/Fd9
	 gDh93LmWEt3l0kKaIs4rR3l2hmo8jgZIEAzDGL8WK7/BnbylYHn0/ARznsixogwzHh
	 daI/6hqs+1KNrTpgIw2yeBDR99mSqRAkkNS21uaVpd/hv6ICSrMRwOW0vC0gMNg3c2
	 Af5YBBR7yelDA==
Message-ID: <sashiko-outbox-184340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 10/10] perf ftrace: Filter
 extraneous functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-11-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-11-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:29:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf ftrace: unshifted target_root_depth in ftrace_task_state__r=
ekey()
- [Low] perf tests ftrace: missing ensure_synthetic_inline() in test_graph_=
target_filter()
--

commit 79ad3a54d36210f71bcd95c62c94ed00575efdc0
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit adds userspace callgraph target state tracking and return-addre=
ss
caller validation to perf ftrace so that extraneous top-level functions and
detached orphan calls are suppressed when filtering with -G / --graph-funcs.
It also replaces the fixed-size call stack with a dynamically reallocated
array and adds unit tests in tools/perf/tests/ftrace.c.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 0aef2cd9b07fb..3591883b32041 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -1492,6 +1492,2259 @@ static int test_context_switch_handling(void)
>  }
>  #undef TEST_CS_ASSERT
> =20
> +static int test_graph_target_filter(void)
> +{
[ ... ]
> +	vmlinux =3D vmlinux_path__find();
> +
> +	/* 6. Test targeted leaf call with synthesized DWARF inlines closing an=
d resetting filter */
> +	if (vmlinux) {
> +		const char *inlined_names[FTRACE_MAX_INLINES];
> +		int num_inlines;
> +		int j;
> +		const char *saved_vmlinux =3D symbol_conf.vmlinux_name;
> +		bool saved_ignore_buildid =3D symbol_conf.ignore_vmlinux_buildid;
> +
> +		symbol_conf.vmlinux_name =3D vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid =3D true;
> +		if (perf_ftrace__setup_inlines(&ftrace) =3D=3D 0 && ftrace.machine) {
> +			num_inlines =3D ftrace_resolve_inlines(ftrace.machine,
> +							     "wake_up_new_task", 0x1d1,
> +							     inlined_names,
> +							     FTRACE_MAX_INLINES);
> +			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {

[Severity: Low]
In test_graph_target_filter(), perf_ftrace__setup_inlines() creates a fresh
machine and loads vmlinux before querying ftrace_resolve_inlines() for
wake_up_new_task at offset 0x1d1.

Other inline tests in tools/perf/tests/ftrace.c, such as
test_inline_processing(), test_stack_saturation(), and
test_context_switch_handling(), call ensure_synthetic_inline() first:

	if (perf_ftrace__setup_inlines(&ftrace) =3D=3D 0 && ftrace.machine) {
		ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
					"activate_task");
		num_inlines =3D ftrace_resolve_inlines(ftrace.machine,
						     "wake_up_new_task", 0x1d1,
						     inlined_names,
						     FTRACE_MAX_INLINES);

Should test_graph_target_filter() also call ensure_synthetic_inline() before
ftrace_resolve_inlines() so that subtests 6, 6b, and 6c are not silently
skipped when the host vmlinux does not have activate_task inlined at exact
offset 0x1d1 of wake_up_new_task?

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 384fc03850f27..4e916096a9380 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> @@ -313,6 +345,26 @@ static struct ftrace_task_state *ftrace_task_state__=
rekey(struct ftrace_task_sta
>  			for (j =3D to_copy; j < ts->depth; j++)
>  				free(ts->stack[j].name);
> =20
> +			if (ts->in_target &&
> +			    ts->target_root_frame_idx < ts->depth) {
> +				existing->in_target =3D true;
> +				existing->target_root_depth =3D ts->target_root_depth;
> +				existing->target_root_frame_idx =3D
> +					split_idx + ts->target_root_frame_idx;
> +				existing->target_root_indent =3D ts->target_root_indent;
> +				strlcpy(existing->target_root_name,
> +					ts->target_root_name,
> +					sizeof(existing->target_root_name));
> +				existing->orphan_depth =3D ts->orphan_depth;
> +			} else if (existing->in_target) {
> +				if (existing->target_root_frame_idx >=3D old_split_idx) {
> +					existing->target_root_frame_idx +=3D
> +						(split_idx + to_copy) - old_split_idx;
> +					existing->target_root_depth +=3D
> +						(split_idx + to_copy) - old_split_idx;
> +				}
> +			}
> +
>  			existing->depth =3D split_idx + to_copy + post_count;
>  		}

[Severity: Medium]
When ftrace_task_state__rekey() splices ts->stack[0 .. to_copy - 1] into
existing->stack at split_idx, existing->target_root_frame_idx is shifted by
split_idx, and the else-if branch shifts both target_root_frame_idx and
target_root_depth. However, in the ts->in_target branch,
existing->target_root_depth is set to ts->target_root_depth without adding
split_idx (and the guard checks ts->target_root_frame_idx < ts->depth rather
than to_copy).

If a task enters non-target ancestor frames on one CPU (leaving split_idx >=
 0
on existing->stack) and then migrates to another CPU where it enters a targ=
et
root function at ts->target_root_depth =3D=3D 0 before the context-switch b=
anner
is processed, existing->target_root_depth will remain 0 after the merge
instead of split_idx.

When that happens, won't ftrace_check_target_caller() and
ftrace_process_fgraph_line() treat the pre-migration non-target ancestor
frames at indices 0 .. split_idx - 1 as being at or above target_root_depth:

ftrace_check_target_caller()
	if (has_retaddr && caller_idx >=3D 0 && caller_idx < cs->target_root_depth=
) {
		ftrace_unwind_to_depth(cs, caller_idx + 1, blank_prefix, out);

ftrace_process_fgraph_line()
	if (!has_filter || (cs->in_target && match_idx >=3D cs->target_root_depth)=
) {

allowing non-target ancestor calls and exits to leak into the filtered outp=
ut,
or unwinding into ancestor inline frames when the target root exits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D10
