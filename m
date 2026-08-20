Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FA4734FF;
	Thu, 20 Aug 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233420; cv=none; b=MshY95hhjhCfALVFMO6YvIYFdVdBSWyoaP4MkYSXiFjJlP2OnVi3XRqMqtdDKNjgXd4sVr9ZxE+/g1cuFgi1EEz3H8TmcfB2biYOA9W/93Po9oyQcyAs5m3WoHCidsF5JotfyyxahiR86gE2UVKChdZuEs0P/appF2aGnHAHGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233420; c=relaxed/simple;
	bh=KGluGObZMLovf5lAuwLuBdX4IHz7Ag8sVShXpObJj/Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HHCn7gBi1axBfVZfvZD/Lv0Zg45ta7Y0/Mil8CJvPHaPNfrNSOkaAXwUsPfpiNQdmRnDKONho8QmQr+rKGdpkcu6r216UgdSTVn3Gyraj+Du3i7TS9zy7PO07aiSlfPhqL4NUjnDtzI7bWMjGushRqwOhPIcqQMAUTCZlGWqnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnUvMYE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnUvMYE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34541F00A3A;
	Thu, 20 Aug 2026 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787233418;
	bh=7aFbVUDhsUFPMgflHKry89Uv6a0Y1A+yDsqErYUtiC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dnUvMYE9pdRnw/2Pskl2vyQrii7t4OwtidhVqpII/XcaIpWpFDT1VtgJmSpkUzKQV
	 IKnInGJtC34vXzBVuN6cHE3Dbx6XD8bI9/APQTmzOcoWQhksk2WAVwu3gUw4IdyyJu
	 9Xct7a/hFRm+c9w+50sZn/hJAirXgcBxeWM6Cltrg0jBGF5mMe4IsD+jkrd3s8Rq2Z
	 5/ofEQoVEoswKEPBcHHMTvZOPPTJtAKb6lYPQ1HW6rgDkQVzyymdwUrjnoQl8foKd7
	 DxayzXilxtizWUb6gUnokaMasWtCeoiqeO614WQ+eouT+cIcv1Xp1IRnS09xm+dTZx
	 Y9fOdy2ojPBHA==
Date: Thu, 20 Aug 2026 22:43:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Message-Id: <20260820224334.faf2b4f78b383318748a8ff5@kernel.org>
In-Reply-To: <20260820091443.f839ba0d307a810714ea8f27@kernel.org>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611683120.237811.15904891776099424430.stgit@devnote2>
	<20260807155802.F06041F000E9@smtp.kernel.org>
	<20260820091443.f839ba0d307a810714ea8f27@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 20 Aug 2026 09:14:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Pre-existing issues:
> > - [High] Lockless traversal of `kprobe_blacklist` can lead to Use-After-Free during module unload.
> 
> This seems a funny hallucination... why have you pointed unrelated kprobe things??

Ah, no.

> > [Severity: High]
> > This is a pre-existing issue, but can the lockless traversal in the
> > blacklist check lead to a use-after-free during module unload?
> > 
> > When parsing the breakpoint, the call chain goes through:
> > arch_modify_local_hw_breakpoint_addr() -> hw_breakpoint_arch_parse() ->
> > arch_build_bp_info() -> within_kprobe_blacklist()

Hmm, why it checks kprobe_blacklist... that is for kprobe handlers (mainly
because avoiding obviously nested kprobes). Anyway, we can make the list
rcu-safe.

> > 
> > kernel/kprobes.c:__within_kprobe_blacklist() {
> >     ...
> >     list_for_each_entry(ent, &kprobe_blacklist, list) {
> >         if (addr >= ent->start_addr && addr < ent->end_addr)
> >             return true;
> >     }
> >     ...
> > }
> > 
> > If a module is unloaded concurrently, kprobe_remove_area_blacklist() deletes
> > entries and immediately frees them with kfree(). Would a concurrent hardware
> > breakpoint modification dereference freed memory here since kprobe_mutex
> > is not held and RCU protection is not used?

Yes, it will be possible.

Thanks,

> > 
> > > +	if (ret) {
> > > +		counter_arch_bp(bp)->address = old_addr;
> > > +		bp->attr.bp_addr = old_addr;
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/178611679753.237811.10190793347982785419.stgit@devnote2?part=3
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
