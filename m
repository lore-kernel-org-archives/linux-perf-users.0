Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E321865F0;
	Tue,  3 Sep 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349778; cv=none; b=lZgOEr7m/wbUkF74pl+c6L1/hBV8JRFmSVv/vYwKyWDbLuQ/6IaHNUCGbLC6S7p1oymtkK+AnlYz6gqQWdiYGIwbmJqmBr/b0vHIe9sSnWrCuaMepixFL1fVdHIt7fgC28p0vMpuiQyjJS4ife79Jljp5MhVoC5ksMOeE5hTFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349778; c=relaxed/simple;
	bh=NynGeVGRLiIIptchbtYIlVyw/4sUgyNxoVN4UKMaNVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCWCikrTeD6rPw5b3Ey6uj6fEfSdiPsK0hh9+ILf1AUlBn19CTgJTh8hnuJ1Ep8F4lkiG2QS22pFdb9NBkoGhRu6nj6tyUhLoWDbRUMxW+n9QTv9uiiV5rQO1DCP706Cfvdj1DHRlmwpnI+m2C7mH0zcSbHD5nhpbicrLRUOYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mK250mKA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mK250mKA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4833qGl9016074;
	Tue, 3 Sep 2024 07:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=jpIUPMBsgKLBoLrI4lPNHTavWE
	swYHQ7aB2xqB6Qjdc=; b=mK250mKAGP+OCzwTWduTeGYYOAOELEY7rlk7WptA82
	yDlt3bkuOzUfarPk4sH+OvdvMoMgJI64/l89yTw6Ts0KBhvyoS1RGnEJYgMe9iPB
	NTmAhyDzH5dOIQQ7LuM0eQta3zaygGKKUJMpnK8dweL7hFxH6hvTxphCGfP1K0CR
	9sogMkAVkbQieo3WNlNvEJWuAp6XaFTmgTcIlADDo86gJsLd8Gp84UJRD0DPVKI9
	QUuYDR+WTZmFmbhpCCDJ/pzFieW9nxaTmJY0+pXqSkqfD0O5ib874MFkS0+ovDua
	2iTR6rBxfgsJn7HkEDy/xN/vgAXfCmdePn63fxElpHKg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9cg71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:49:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4837nH9U006286;
	Tue, 3 Sep 2024 07:49:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9cg6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:49:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48370Z4H018437;
	Tue, 3 Sep 2024 07:49:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw11uu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:49:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4837nEmU31261150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 07:49:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E80F82004D;
	Tue,  3 Sep 2024 07:49:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E2BC20043;
	Tue,  3 Sep 2024 07:49:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 07:49:13 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung
 Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter
 <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
In-Reply-To: <20240903073629.2442754-1-svens@linux.ibm.com> (Sven Schnelle's
	message of "Tue, 3 Sep 2024 09:36:28 +0200")
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
	<20240903073629.2442754-1-svens@linux.ibm.com>
Date: Tue, 03 Sep 2024 09:49:13 +0200
Message-ID: <yt9dikvd9nye.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5qDwM7DHPNcnrUrXpyBSHkESBqBIL7xR
X-Proofpoint-ORIG-GUID: PTWKogaR7ggYWo3l4oCSAgeI_kElt-UG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=295 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030059

Hi Michael,

Sven Schnelle <svens@linux.ibm.com> writes:

> The following KASAN splat was shown:
>
> [   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
> [   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
> [   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
> [   44.505479]
> [   44.505486] CPU: 51 UID: 0 PID: 1384 Comm: sh Not tainted 6.11.0-rc6-next-20240902-dirty #1496
> [   44.505503] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
> [   44.505508] Call Trace:
> [   44.505511]  [<000b0324d2f78080>] dump_stack_lvl+0xd0/0x108
> [   44.505521]  [<000b0324d2f5435c>] print_address_description.constprop.0+0x34/0x2e0
> [   44.505529]  [<000b0324d2f5464c>] print_report+0x44/0x138
> [   44.505536]  [<000b0324d1383192>] kasan_report+0xc2/0x140
> [   44.505543]  [<000b0324d2f52904>] special_mapping_close+0x9c/0xc8
> [   44.505550]  [<000b0324d12c7978>] remove_vma+0x78/0x120
> [   44.505557]  [<000b0324d128a2c6>] exit_mmap+0x326/0x750
> [   44.505563]  [<000b0324d0ba655a>] __mmput+0x9a/0x370
> [   44.505570]  [<000b0324d0bbfbe0>] exit_mm+0x240/0x340
> [   44.505575]  [<000b0324d0bc0228>] do_exit+0x548/0xd70
> [   44.505580]  [<000b0324d0bc1102>] do_group_exit+0x132/0x390
> [   44.505586]  [<000b0324d0bc13b6>] __s390x_sys_exit_group+0x56/0x60
> [   44.505592]  [<000b0324d0adcbd6>] do_syscall+0x2f6/0x430
> [   44.505599]  [<000b0324d2f78434>] __do_syscall+0xa4/0x170
> [   44.505606]  [<000b0324d2f9454c>] system_call+0x74/0x98
> [   44.505614]
> [   44.505616] Allocated by task 1384:
> [   44.505621]  kasan_save_stack+0x40/0x70
> [   44.505630]  kasan_save_track+0x28/0x40
> [   44.505636]  __kasan_kmalloc+0xa0/0xc0
> [   44.505642]  __create_xol_area+0xfa/0x410
> [   44.505648]  get_xol_area+0xb0/0xf0
> [   44.505652]  uprobe_notify_resume+0x27a/0x470
> [   44.505657]  irqentry_exit_to_user_mode+0x15e/0x1d0
> [   44.505664]  pgm_check_handler+0x122/0x170
> [   44.505670]
> [   44.505672] Freed by task 1384:
> [   44.505676]  kasan_save_stack+0x40/0x70
> [   44.505682]  kasan_save_track+0x28/0x40
> [   44.505687]  kasan_save_free_info+0x4a/0x70
> [   44.505693]  __kasan_slab_free+0x5a/0x70
> [   44.505698]  kfree+0xe8/0x3f0
> [   44.505704]  __mmput+0x20/0x370
> [   44.505709]  exit_mm+0x240/0x340
> [   44.505713]  do_exit+0x548/0xd70
> [   44.505718]  do_group_exit+0x132/0x390
> [   44.505722]  __s390x_sys_exit_group+0x56/0x60
> [   44.505727]  do_syscall+0x2f6/0x430
> [   44.505732]  __do_syscall+0xa4/0x170
> [   44.505738]  system_call+0x74/0x98
> [..]

As this has a dependency on your special mapping close series, do you
want to carry that with your patches?
