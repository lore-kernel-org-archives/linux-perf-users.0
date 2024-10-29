Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED71D8E0F;
	Tue, 29 Oct 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228163; cv=none; b=KRYUTWdO4uHy5QPsoidWCIEVU33/ATOXCqmCFh6geGJaIxSAPSEx1INFs8/0F1KY7iHAI2qmoLn4d+7meTlgBqKJuy0THLfyKfwN6i4vrfO2G4oRCQymnqmH1koUb3d6OTqvHZQw91RFp/Oym/5cTkfBP/34zh4vrh7ctlTIpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228163; c=relaxed/simple;
	bh=Qmrrcd6oQcoAQSl7qPXGbEiEVMoJ4g1HbbWd5DCSqt4=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=XP3d0B43LkxtxgY66aFChbjbz9GzjxG3puZsxa+N1ImH6gTUehH4SFlLpm6+lTPhaub1ni+QNiXRbZW9cD10NkQZ9gCd7iPK21H8a7l7H0+LQBP6a6rQ8m4yz5FyGG64Dh+RZUoFBLAU0CWzMCp4TUAp+k0Dq+UReG2kyEXZdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F9INojBx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F9INojBx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TFRbB7029122;
	Tue, 29 Oct 2024 18:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mK/4Bz
	cHnCxFoi+e4s0kq2SmjqHQX1oEGf7zQ10nHjo=; b=F9INojBxgQGX2wjLDacJ1L
	xPqOr18v4B5p0KHbjVuaXGKOwhnxAy7kf7T5UkAUw1HMZsq6DfSk6I6C6zEfdCKO
	I8DiG0pvIrIX4TywZgs0LLsGBsJvVxc7eMDZi6nTjC8UW0OQ4NtQR5pGXtQPL4Lc
	damqtywGXIphHDWUughFG1vgmwzuLY7TdlPGcjnzgnQsfVjv4vPC1on55oGwS83Z
	cwQarw1zEQfJ9iIBnnDCGb9HAvzEa9TxnUyKkmm6IeeB/mW5cbMGKTkzooKfzjt4
	eD+Se4suk3EZBfgw4j1hAP3+1rJcN0sk5u+/R+m+bUsCyZC0KQHH2v5s2LZFb0KA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nstp45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:55:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49TItf7d032429;
	Tue, 29 Oct 2024 18:55:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nstp3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:55:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49THgeSG028275;
	Tue, 29 Oct 2024 18:55:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xvk82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:55:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TItZ0m50987366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:55:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FBE52004B;
	Tue, 29 Oct 2024 18:55:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F54D20043;
	Tue, 29 Oct 2024 18:55:15 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.246.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Oct 2024 18:55:14 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH v5 00/10] Run tests in parallel showing number of tests
 running
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Date: Wed, 30 Oct 2024 00:25:00 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Howard Chu <howardchu95@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Veronika Molnarova <vmolnaro@redhat.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Message-Id: <07039967-2BFC-4D84-AC3E-F98CD510BD3F@linux.vnet.ibm.com>
References: <20241025192109.132482-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFd9qDpkpRylfJHdAwYyl8nTcSrFyUar
X-Proofpoint-GUID: L1oELwVRbIbHCw2HsJjuop8SDzF_fvtV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290139



> On 26 Oct 2024, at 12:50=E2=80=AFAM, Ian Rogers <irogers@google.com> wrot=
e:
>=20
> Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> to read them for display. When running on a color terminal, display
> the number of running tests (1 if sequential). To avoid previous
> flicker, only delete and refresh the display line when it changes. An
> earlier version of this code is here:
> https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/
>=20
> Add a signal handler for perf tests so that unexpected signals are
> displayed and test clean up is possible.
>=20
> In perf test add an "exclusive" flag that causes a test to be run with
> no other test. Set this flag manually for C tests and via a
> "(exclusive)" in the test description for shell tests. Add the flag to
> shell tests that may fail when run with other tests.
>=20
> Change the perf test loop to run in two passes. For parallel
> execution, the first pass runs all tests that can be run in parallel
> then the 2nd runs remaining tests sequentially. This causes the
> "exclusive" tests to be run last and with test numbers moderately out
> of alignment.
>=20
> Change the default to be to run tests in parallel. Running tests in
> parallel brings the execution time down to less than half.
>=20
> v5: Make width robust to signal delivery (Namhyung). Minor signal
>    print message tweaks and test kill value.
>=20
> v4: Add patch to sort exclusive tests last, this allows for increasing
>    test numbers as requested by Namhyung.
>=20
> v3: Mark additional shell tests as "(exclusive)" to avoid issues with
>    shared resources suggested by Namhyung. Add dependent signal
>    handler change so that kill/ctrl-C don't leave lots of processes,
>    previously sent here:
>    https://lore.kernel.org/lkml/20241017052137.225514-1-irogers@google.co=
m/
>=20
> v2: Fix inaccurate remaining counts when running specific
>    tests. Rename "remaining" to "active" to better reflect the
>    testing behavior. Move the exclusive flag to test cases and not
>    entire suites. Add more "(exclusive)" flags to test as
>    suggested-by James Clark. Remove "(exclusive)" flag from test
>    descriptions to keep the command line output more concise. Add
>    James Clark's tested-by.
>=20
> Ian Rogers (10):
>  tools subcmd: Add non-waitpid check_if_command_finished()
>  perf test: Display number of active running tests
>  perf test: Reduce scope of parallel variable
>  perf test: Avoid list test blocking on writing to stdout
>  perf test: Tag parallel failing shell tests with "(exclusive)"
>  perf test: Add a signal handler around running a test
>  perf test: Run parallel tests in two passes
>  perf test: Make parallel testing the default
>  perf test: Add a signal handler to kill forked child processes
>  perf test: Sort tests placing exclusive tests last

Tested-by : Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@lin=
ux.vnet.ibm.com>>

Thanks
Athira Rajeev
>=20
> tools/lib/subcmd/run-command.c                |  33 ++
> tools/perf/tests/builtin-test.c               | 408 ++++++++++++------
> .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> tools/perf/tests/shell/list.sh                |   5 +-
> .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
> .../shell/record+script_probe_vfs_getname.sh  |   2 +-
> tools/perf/tests/shell/record.sh              |   2 +-
> tools/perf/tests/shell/record_lbr.sh          |   2 +-
> tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> tools/perf/tests/shell/stat_bpf_counters.sh   |   2 +-
> tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
> tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
> tools/perf/tests/task-exit.c                  |   9 +-
> tools/perf/tests/tests-scripts.c              |   7 +-
> tools/perf/tests/tests.h                      |   9 +
> tools/perf/util/color.h                       |   1 +
> 27 files changed, 367 insertions(+), 145 deletions(-)
>=20
> --=20
> 2.47.0.163.g1226f6d8fa-goog
>=20

