Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92615191F98
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692370; cv=none; b=aw2b8kh+H1TwcMc96SUS0AH6+biCf1N5q528CPzbzu+wkB+9hFlYlYPjVK5WEd3HSFq2HP+pmtXq1mrDjJsq2qL1VI09yDpijmdEgEvgnIKnUhVg7/KoNnPq5n0OHGWnLgqECbxNAqBvUzAwq6pTOiTfktaR0JSPjp2/1NSy6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692370; c=relaxed/simple;
	bh=wirYQqjSAHbTODQX9vQDFZJRpG0gxBp22RIwsGZ14RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QN7c18Tje3VSdanTWp9EYMRTlEAR7EPMGSQLpCq8eGDTc279A96NafvRiNzUhbsmzvlik5TyrBlGxR0hIEINLaLAWkQILDftC0jbuxFhLkMgY7q12cStKb7NXYF2F0bc7ryzumIRrlOQwWhxDeZ/bESNiZ+7czuaDR/wZIKls7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpDnihEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpDnihEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ED41F00893;
	Fri,  5 Jun 2026 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692369;
	bh=beBYbJZYro6fObeA5d0mu7J5zSKmqIRm28UtzAFAQdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpDnihElx/i0q6tcJ2u4HGH/Ek4Y6HpXX0/LXfFla3OcJWNu3s7kVQaxvBaG/p4S6
	 JjWONxLzq9GyIH1IxKQNxmRzeefOCMdxda4KE2l9t5rqbF4eNO8y8AyHDbkHOXKxIt
	 /6LPNw9xMZKA7nlvrLC62LrhYvKWKhDmXkJK3mc3AQUm4zuvI3D1ioX1hmwnIwKbkW
	 qMK+1VmgaT+4RzQzL0Ql5bqU1o+/Ry1wQ72ukxad81e1WaQD2wZIdTXuxEsROOie1+
	 zO8/mukZWRuDfzG5IvCoPRAX7gSke//s58+Q9TG9CTQ/RH8JbdHMxvsgnzJ6lwOIjy
	 UM3OMfRToae0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf sched: Replace BUG_ON and add NULL checks in
 replay event helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-9-acme@kernel.org>
References: <20260605203316.1758661-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:46:08 +0000
Message-Id: <20260605204609.23ED41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in register_pid() due to unbounded strcpy=
() from untrusted input.
--

commit d49e324b240110a80380fd996077045c127efafa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Replace BUG_ON and add NULL checks in replay event helpers

This commit replaces BUG_ON() calls with graceful error handling and adds
missing NULL checks for memory allocations in the perf sched replay helpers.
It ensures the tool returns early instead of crashing when processing
untrusted perf.data input that triggers memory exhaustion.

>     get_new_event() has three issues:
>    =20
>     1. The zalloc() result is dereferenced without a NULL check, crashing
>        on allocation failure.
>    =20
>     2. BUG_ON(!task->atoms) kills the process when realloc() fails.
>        Since perf.data is untrusted input, this should be a graceful erro=
r.

[Severity: Critical]
This is a pre-existing issue, but since perf.data is treated as untrusted
input, does register_pid() have a heap buffer overflow?

When register_pid() allocates a new task_desc, it blindly copies the comm
parameter into a fixed-size buffer:

tools/perf/builtin-sched.c:register_pid() {
	...
	task =3D zalloc(sizeof(*task));
	task->pid =3D pid;
	task->nr =3D sched->nr_tasks;
	strcpy(task->comm, comm);
	...
}

If a crafted perf.data file supplies a trace event containing a comm
string significantly longer than the task->comm array (typically 16 bytes),
could this unbounded strcpy() overflow the buffer and overwrite subsequent
struct fields like nr_events or the atoms array pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D8
