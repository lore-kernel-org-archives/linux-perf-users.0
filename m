Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9603FFD
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785110050; cv=none; b=KEyrZeLQD10OxiWxb3aoio/EDBO4eV4+oRI+/KFyxn6c3jzTsunzsEKsDKUh1Cit90niPQ5izE8UOYkH45dASHszS3JMei3D2uaPZEnW0oghec2Z2sM3vKCOfqnrpaAyD7juZ67BU5OFyJsfD5nAis5fbIgi2Sir/HM4PyqpnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785110050; c=relaxed/simple;
	bh=F0ZnJMs73KQyST/8KO2dSOTDbvDzGKTW5OOw2an+4Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjgagFEHI1+WzejeoiBqeOysn64vMYC895yrWO1H5rmUXOIudFwrD4TGO0L5ZejyP56C21uzQN8BYWBsHw4k5oUtTgcb5rggjGa4rXtSTcvwtMPqv233yGOIqi0lDy3n2I1rOBTJWNJXd6L4/iiGi10Sc6v0ngoNzSYQH2cCtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LohEKUe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LohEKUe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D65C1F000E9;
	Sun, 26 Jul 2026 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785110048;
	bh=7E/v0ZOHu3CGKCUr35PWSbOTDuw3ySPZtfugYKFZvEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LohEKUe70HgsIGZ+2/5b1/xwm/sSjsk8daTqFqWN6mDjkx1ohVc9Y+Xgd+vxtogng
	 5+aAnuM4hQ8zXi+92lfGnbOcYvG17twNS/OAQSHzaHL8BpR9DuK/cPG78IJtDf5Gqk
	 10+BvuAbL2SwSauBpAIzSx1knCn/Hfs36hVeg6W+j4ia2OL8sYtmt3G6Xuk0mdDBwA
	 YIbDO46MQaG43rroekX61rh6dWFayDAJcY78vwAeSaz1LrrxbOF7jnvSQvQ1i7p3w0
	 6EkVrDuiVqPL7OXIKcDzzJbf/i8rdyX1FtPmPmSN9nqlHKpi0xqhwztNrzbsT35Jw+
	 x+2/mUs/eYN2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] perf machine: Fix NULL parent dereference in fork
 event processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726234014.63111-3-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
 <20260726234014.63111-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 23:54:08 +0000
Message-Id: <20260726235408.8D65C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized pointer dereference in `threads__remove`.
- [Medium] TOCTOU / Key-value mismatch in `threads__remove` deletes the wro=
ng thread.
--

--- Patch [2]: [PATCH 2/8] perf machine: Fix NULL parent dereference in for=
k event processing ---
commit 44c208f6def23d87c4b23fe6a8843f00fca91108
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Fix NULL parent dereference in fork event processing

This commit fixes a NULL pointer dereference when processing fork events
by adding a NULL guard before accessing the parent thread.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1923,7 +1923,8 @@ int machine__process_fork_event(struct machine *mac=
hine, union perf_event *event
>  	 * (fork) event that would have removed the thread was lost. Assume the
>  	 * latter case and continue on as best we can.
>  	 */
> -	if (thread__pid(parent) !=3D (pid_t)event->fork.ppid) {
> +	if (parent !=3D NULL &&
> +	    thread__pid(parent) !=3D (pid_t)event->fork.ppid) {
>  		dump_printf("removing erroneous parent thread %d/%d\n",
>  			    thread__pid(parent), thread__tid(parent));
>  		machine__remove_thread(machine, parent);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how
machine__remove_thread() eventually calls into threads__remove(), is it
possible for thread__put() to dereference an uninitialized pointer?

In tools/perf/util/threads.c:threads__remove():

struct thread *old_value;
...
hashmap__delete(&table->shard, thread__tid(thread), NULL, &old_value);
thread__put(old_value);

If the thread's TID is not found in the hashmap, hashmap__delete() returns
false and leaves old_value uninitialized. Since the return value is not
checked, thread__put(old_value) will unconditionally execute with whatever
data was left on the stack.

Could this happen during malformed event processing here in
machine__process_fork_event() if thread recreation fails due to memory
pressure, and a subsequent thread removal fails to find the TID in the
hashmap?

[Severity: Medium]
This is also a pre-existing issue, but looking at the same deletion logic
in tools/perf/util/threads.c:threads__remove():

hashmap__delete(&table->shard, thread__tid(thread), NULL, &old_value);

Does this unconditionally delete whatever entry currently matches the TID,
without verifying that the stored value actually matches the thread pointer
passed in?

If machine__process_fork_event() encounters a malformed event where the
TID matches the parent TID but the PIDs differ, the parent is replaced.
Could a subsequent removal of the child thread incorrectly delete this
newly created parent thread from the hashmap instead of failing gracefully?

> 		thread__put(parent);
> 		parent =3D machine__findnew_thread(machine, event->fork.ppid,
> 						 event->fork.ptid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726234014.6311=
1-1-acme@kernel.org?part=3D2
