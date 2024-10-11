Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F05381E;
	Fri, 11 Oct 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668679; cv=none; b=Bvl2F2PTGRnILyPo7q9wj5bsR2RY70wJ7TDRposk2JaHuG+morF11qGOlTmcPTtAF7iJXdOOLIsvBHtBiaGUDb05CSDNA0O4WvZq72iHsr3f+/9Bv7Bs5J40oBqP2XaE21p1QjYXwwT4SNoLbBPaAtYzaHa0YF7HGK8H8egKNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668679; c=relaxed/simple;
	bh=N1OHEM3RxX22n8nFZ39iKOpOgE736ymMlpcnwq6APd4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3xtMyAjBG7gt0HwLS+jgD3jeYBhr3y8JqUg3Szl8KiaPSplNcdXpz6qZw2tmbCiY4kRouejy+xs0DLnBORwM0zvaTA2zAZF+auvFvK7QY/BLlCjcCxKEPWtjb+HPnPqLXEV29HC6K/0P+g4igFm5vnNFq7WqVNPwp/Skolz0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQgwZeN2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQgwZeN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728668678; x=1760204678;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=N1OHEM3RxX22n8nFZ39iKOpOgE736ymMlpcnwq6APd4=;
  b=nQgwZeN2409UTEa37jZ8pgFAlyvKcLtcdhGq4ON1lO8Pde3IstsvpiBe
   c4pJOqumxFp5Bwv8O77xEKLHhJEkUFN+cpIv14G5lpfujiQOJJmtmTfUU
   vGdNczDLDwljV5JASMR8wFaLDEtU7TCbYSdxuvlXSPl9b7nzbL1keNSoL
   W2f4mWmOqRHTerZibIaVFtAybNGoCD9ouUVb/orfxYV24HZ3rErZApeZM
   PaW1lq2OxKHWyMipNmR7Pf+nzXbzO8OgPPXOub27nFEf7Jwn2rB0QQ8XF
   jP7FB+K1PId/wl/4j4UZXm6DHm9jV4jOajN80bnovW481vik7Q+u/c23R
   w==;
X-CSE-ConnectionGUID: Vr3+rJB0TV2UEEgWF/Q7Gg==
X-CSE-MsgGUID: j91WizMzSRCkyklHbAk7sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53484808"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53484808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:44:37 -0700
X-CSE-ConnectionGUID: PZ0nGUhFSMSVDp5VOS6Hjg==
X-CSE-MsgGUID: BdzFP1/TTO2mjsNMiikvVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77176048"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.111.159]) ([10.125.111.159])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:44:36 -0700
Message-ID: <0069d2dd01235b8e301837b041c4db58b296fbab.camel@linux.intel.com>
Subject: Re: [PATCH v6] perf sched timehist: Add pre-migration wait time
 option
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Madadi Vineeth Reddy
	 <vineethr@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>,  Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 acme@redhat.com,  linux-perf-users <linux-perf-users@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Fri, 11 Oct 2024 10:44:35 -0700
In-Reply-To: <Zwf_ep16969kIE2y@google.com>
References: <20241004170756.18064-1-vineethr@linux.ibm.com>
	 <Zwf_ep16969kIE2y@google.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 09:23 -0700, Namhyung Kim wrote:
> Hello Tim,
>=20
> On Fri, Oct 04, 2024 at 10:37:56PM +0530, Madadi Vineeth Reddy wrote:
> > pre-migration wait time is the time that a task unnecessarily spends
> > on the runqueue of a CPU but doesn't get switched-in there. In terms
> > of tracepoints, it is the time between sched:sched_wakeup and
> > sched:sched_migrate_task.
> >=20
> > Let's say a task woke up on CPU2, then it got migrated to CPU4 and
> > then it's switched-in to CPU4. So, here pre-migration wait time is
> > time that it was waiting on runqueue of CPU2 after it is woken up.
> >=20
> > The general pattern for pre-migration to occur is:
> > sched:sched_wakeup
> > sched:sched_migrate_task
> > sched:sched_switch
> >=20
> > The sched:sched_waking event is used to capture the wakeup time,
> > as it aligns with the existing code and only introduces a negligible
> > time difference.
> >=20
> > pre-migrations are generally not useful and it increases migrations.
> > This metric would be helpful in testing patches mainly related to wakeu=
p
> > and load-balancer code paths as better wakeup logic would choose an
> > optimal CPU where task would be switched-in and thereby reducing pre-
> > migrations.
> >=20
> > The sample output(s) when -P or --pre-migrations is used:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >            time    cpu  task name                       wait time  sch =
delay   run time  pre-mig time
> >                         [tid/pid]                          (msec)     (=
msec)     (msec)     (msec)
> > --------------- ------  ------------------------------  ---------  ----=
-----  ---------  ---------
> >    38456.720806 [0001]  schbench[28634/28574]               4.917      =
4.768      1.004      0.000
> >    38456.720810 [0001]  rcu_preempt[18]                     3.919      =
0.003      0.004      0.000
> >    38456.721800 [0006]  schbench[28779/28574]              23.465     2=
3.465      1.999      0.000
> >    38456.722800 [0002]  schbench[28773/28574]              60.371     6=
0.237      3.955     60.197
> >    38456.722806 [0001]  schbench[28634/28574]               0.004      =
0.004      1.996      0.000
> >    38456.722811 [0001]  rcu_preempt[18]                     1.996      =
0.005      0.005      0.000
> >    38456.723800 [0000]  schbench[28833/28574]               4.000      =
4.000      3.999      0.000
> >    38456.723800 [0004]  schbench[28762/28574]              42.951     4=
2.839      3.999     39.867
> >    38456.723802 [0007]  schbench[28812/28574]              43.947     4=
3.817      3.999     40.866
> >    38456.723804 [0001]  schbench[28587/28574]               7.935      =
7.822      0.993      0.000
> >=20
> > Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> >=20
> > ---
> > Changes in v6:
> > - Handle the case of multiple migrations before the task is
> >   scheduled in. (Tim Chen)
>=20
> Are you ok with this now?

Yes, you can add my reviewed-by.

>=20
> Thanks,
> Namhyung
>=20
>=20

