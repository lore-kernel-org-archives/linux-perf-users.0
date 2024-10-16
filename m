Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845218732A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 05:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055553; cv=none; b=KasZNeuWT1tqRjXiCosqO4BVSOs+RQuCJQXPlghypODAja0kIL3RWkmffIxLcppJNgnXjdKu4j0ESPO7YBXPXnJvGLHm0wlGsmj/uup4+cY6dTxG+DfT/S0S8uYZ/zYCxJb4cLnnXL+on6A8ICSR8F9+/1r91zZKw4u+iGF2c5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055553; c=relaxed/simple;
	bh=n9Sa+pXKgKDvAYNQtxbVJKpKXxW32braGlez0WZf3bA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GgIpDftTyXxQaMfk6RcUX79Hsk+kEB8JSvY7jwQOPAVtTJGxyAEDOOZpXXjdF6unQdxx8zR5hxjd1ejO4H90vUTYJxA7icLlrsaTozv0V531M4+uMmIehGRiquqna5ouiv4aknTigNFci2Rq4iacSUUnlVCqxILXlWi43zxKjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EnLsTHCV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EnLsTHCV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G3vnbp027554;
	Wed, 16 Oct 2024 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zpuXYV
	y7p2Vv1O5MWhG2f+F7Dms7BhGQ3R9irG9puoM=; b=EnLsTHCViJZPU4vKPzLxCw
	U9KnBvW2zqrxFOws4XUEb/NCf+q1lcJ1S8ah1uCOyMnNlbApoq9CW/fJRh0Md2kf
	6WMZ9g6OMKeLqhXjxMm8q978t1MrxQRdos9ry7m3RZoaYLgBgnbYwjutZrWE27tw
	A1BExnq6ZamdXlCVTTjezap5bOYLO8N0KVj7g9jdpnjjCeyZhq/bEPjDoBp1Xih/
	XGCjACDCb14M/jlfq8Lu28401+J9plRa6wDToe/BuBdX4Dd9H8rTK8n6Msel0uGj
	FwiCU0uqoyLdSbxwlxzgTbxB2+TQR1xP+7PNa1fWF+SbIqX6znruWwNw7cR90NGg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a60a87ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:12:21 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49G59Z7b006341;
	Wed, 16 Oct 2024 05:12:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a60a87af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:12:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G164So027452;
	Wed, 16 Oct 2024 05:12:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txqh08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:12:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G5CFpq30277898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 05:12:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E17D120040;
	Wed, 16 Oct 2024 05:12:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E29722004B;
	Wed, 16 Oct 2024 05:12:09 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.246.127])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 05:12:09 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/tests/base_probe: Fix check for the count of
 existing probes in test_adding_kernel
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241014153910.85536-1-atrajeev@linux.vnet.ibm.com>
Date: Wed, 16 Oct 2024 10:41:54 +0530
Cc: jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5267822A-8384-4B9A-817F-B764E24F0116@linux.vnet.ibm.com>
References: <20241014153910.85536-1-atrajeev@linux.vnet.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>, vmolnaro@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nYKh2bQzL_ruitaihCt48o0XMnDss4Dt
X-Proofpoint-ORIG-GUID: FC33Hutp5N2QSTDffGWPknApqv7WkLfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160031



> On 14 Oct 2024, at 9:09=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> perftool-testsuite_probe fails in test_adding_kernel as below:
> Regexp not found: "probe:inode_permission_11"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: force-adding probes =
::
> second probe adding (with force) (output regexp parsing)
> event syntax error: 'probe:inode_permission_11'
>  \___ unknown tracepoint
>=20
> Error:  File /sys/kernel/tracing//events/probe/inode_permission_11
> not found.
> Hint:   Perhaps this kernel misses some CONFIG_ setting to
> enable this feature?.
>=20
> The test does the following:
> 1) Adds a probe point first using :
>    $CMD_PERF probe --add $TEST_PROBE
> 2) Then tries to add same probe again without =E2=80=94force
> and expects it to fail. Next tries to add same probe again
> with =E2=80=94force. In this case, perf probe succeeds and adds
> the probe with a suffix number. Example:
>=20
> ./perf probe --add inode_permission
> Added new event:
>  probe:inode_permission (on inode_permission)
>=20
> ./perf probe --add inode_permission --force
> Added new event:
>  probe:inode_permission_1 (on inode_permission)
>=20
>  ./perf probe --add inode_permission --force
> Added new event:
>  probe:inode_permission_2 (on inode_permission)
>=20
> Each time, suffix is added to existing probe name.
> To get the suffix number, test cases uses :
> NO_OF_PROBES=3D`$CMD_PERF probe -l | wc -l`
>=20
> This will work if there is no other probe existing
> in the system. If there are any other probes other than
> kernel probes or inode_permission, ( example: any probe),
> "perf probe -l" will include count for other probes too.
>=20
> Example, in the system where this failed, already some
> probes were default added. So count became 10
>  ./perf probe -l | wc -l
>  10
>=20
> So to be specific for "inode_permission", restrict the
> probe count check to that probe point alone using :
> NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l`
>=20
> Similarly while removing the probe using "probe --del *",
> ( removing all probes ), check uses:
>=20
> ../common/check_all_lines_matched.pl "Removed event: =
probe:$TEST_PROBE"
>=20
> But if there are other probes in the system, the log will
> contain reference to other existing probe too. Hence change
> usage of check_all_lines_matched.pl to check_all_patterns_found.pl
> This will make sure expecting string comes in the result
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Adding Veronika in the mail. Sorry missed to add initially. Please share =
review comments on this fix.

Thanks
Athira
> ---
> tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh =
b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index d541ffd44a93..f8b5f096d0d7 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -169,7 +169,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE =
"force-adding probes :: second pr
> (( TEST_RESULT +=3D $? ))
>=20
> # adding existing probe with '--force' should pass
> -NO_OF_PROBES=3D`$CMD_PERF probe -l | wc -l`
> +NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> $CMD_PERF probe --force --add $TEST_PROBE 2> =
$LOGS_DIR/adding_kernel_forceadd_03.err
> PERF_EXIT_CODE=3D$?
>=20
> @@ -205,7 +205,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE =
"using doubled probe"
> $CMD_PERF probe --del \* 2> =
$LOGS_DIR/adding_kernel_removing_wildcard.err
> PERF_EXIT_CODE=3D$?
>=20
> -../common/check_all_lines_matched.pl "Removed event: =
probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < =
$LOGS_DIR/adding_kernel_removing_wildcard.err
> +../common/check_all_patterns_found.pl "Removed event: =
probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < =
$LOGS_DIR/adding_kernel_removing_wildcard.err
> CHECK_EXIT_CODE=3D$?
>=20
> print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple =
probes"
> --=20
> 2.43.5
>=20
>=20

