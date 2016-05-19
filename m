From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Detecting cache line sharing with perf / ocperf
Date: Wed, 18 May 2016 18:52:43 -0700
Message-ID: <87h9duyftg.fsf@tassilo.jf.intel.com>
References: <B99D9D85-737A-408A-990A-BAA6F60CC0DD@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40853 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbcESBwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 May 2016 21:52:45 -0400
In-Reply-To: <B99D9D85-737A-408A-990A-BAA6F60CC0DD@akamai.com> (Nicholas
	Pavey's message of "Wed, 18 May 2016 15:10:40 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Pavey, Nicholas" <npavey@akamai.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

"Pavey, Nicholas" <npavey@akamai.com> writes:

> I=E2=80=99m hoping to read the performance counters to detect cache l=
ine sharing (both true and false).
>
> I=E2=80=99ve got the very useful =E2=80=98ocperf=E2=80=99 tool, which=
 gives me a much wider
> range of symbolic performance counter options. My problem is that the
> specific programming seems to vary by processor micro-architecture.

% ocperf.py  list | grep hitm
  mem_load_uops_l3_hit_retired.xsnp_hitm      [Retired load uops which
  data sources were HitM responses from shared L3. (Supports PEBS)
  Errata: HSM26, HSM30]
    mem_load_uops_l3_miss_retired.remote_hitm   [Retired load uop whose
  Data Source was: Remote cache HITM (Supports PEBS) Errata: HSM30]

If you want to sample you'll likely also want to enable PEBS (:pp)

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
