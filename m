Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595D18024
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814666; cv=none; b=RZ8lJhINuOzUWSUS3qVKqfDbkuaNhOkqCeH427OuoX+Fy6prqow/K4xHcGvGoisMRkUxO9fP3Omb+ZHAWcN5Yxiygre6PrXxFra2+zgvTPdys8DHd6pw3MehNbAsT/9cV5xhdVEzbC3nwAklU7tb0mkCmXXC5uqJFeDto5xrsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814666; c=relaxed/simple;
	bh=xHiHEFMUqtxJ1o9/wgXPm+ofqRlVduq4yuIB0BXDw1k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UzNzEJp8nG2//HFQQFlG8YCeqVaiepKxP2STByWJX024742a97cdGOU4zzslGvc6b8CvVPpv5HMfHraVeq8cWdzRWfD6KuJto2qLgJBqjIPp3EEKLHIA1+8mAjqN5bLCGciASFowYu6FDMV6hUQRjNfeVyl8/6gcFa3uUkcitPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I9ZOSMHA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9ZOSMHA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I49XJu3308834;
	Wed, 18 Mar 2026 06:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=91kn9a
	TCOYAyekZhNplPr8uvIrganIzdnjl4/o7++Uk=; b=I9ZOSMHAnB+9QhWKYlLR5M
	9ILhv3BUZVVLzQ/zaKefF8x7SbYSYVT+PeN72Sz9ZANSy2HbqK8AaLqVYzw8UyKP
	Q4fqyiqlNA2tNfI5hw9Nwf6hDT907qDmdNXR9rguOPvysu1GSQiYYYMHoKPOkxMy
	QKvK0gU1kHGzBiEOqJQflsv+8r5XKtyZJsWILDbBSqHH74aThazTMsmewLzyyZhz
	4C4PgNkk4u59NCQ0UtDDyTHbmsgYVFxcZpnJLa8VfxQ4XmHIBvWQ9KsVqlFVNszA
	u3jaxipSK1pr06kSni5BVjE9zSsUN+/nVMYvIa2/ODVOEco3wlPvVGRWXQE6EacA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs8fb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:17:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I63BNk032397;
	Wed, 18 Mar 2026 06:17:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jvh1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:17:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I6HUgS43712922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 06:17:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B5FC2004D;
	Wed, 18 Mar 2026 06:17:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 249E220040;
	Wed, 18 Mar 2026 06:17:28 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.25.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Mar 2026 06:17:27 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tools/perf/tests: Update debuginfo check in
 skip_if_no_debuginfo
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fU8VojUXB9oD1u713WeHQ9oLBn0fQ0=Kif0XetxMg7MGw@mail.gmail.com>
Date: Wed, 18 Mar 2026 11:47:16 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        jbrnak@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8DCECF2-017F-4B09-9E95-7D5CF992B0FB@linux.ibm.com>
References: <20260314083722.76728-1-atrajeev@linux.ibm.com>
 <CAP-5=fU8VojUXB9oD1u713WeHQ9oLBn0fQ0=Kif0XetxMg7MGw@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba437f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=mVReGz3YqwRXvHoZY9AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x0oYVBi789h0XHlRce-qTS-E_wY2Ej3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1MSBTYWx0ZWRfXzlvdd+fUxOH3
 JvE/xDPpyreYbpKZQBq1zJJghaRwJQ2STy7mmuH8ooq1/JIBq2uOOSrx16OjQAPA/N7GbycQWMk
 SrUrPUXzyW7zBN+2lVAZitVsFQX/QsZKCQvwQakOTk2LQgnrvVt5U+w33mvvI221Ia0io5MBsLK
 iR1+WhiubBnqX+XzcZJqhpRiYA5ffevLBoKBFp+C1fdIHHYkt8BqkE1ZFFoATB+FAhJQJ2Zf6Pq
 oEVjp0shNzaqtnkxLo2eCqtAvlN0r59Q/X3QdqlFfWLKNCBEIR1MRMBTLdwTphixYvBEIykVgSx
 IBie1YTTLzhjNOaHUAeaLZKRtRO1OCQOsj/plNxAGrZvipbcDauV9/gZjyDNr2PFB+DTA7o4iuj
 C1j1QXa1pyJOFzE2+JeTc7gypL7lVJBcP5Z4Q/313Qy9natgQLfdTupMFnmZZgOmwSONgvdAEtY
 CMdIG8OTmV+r2Iv/zYA==
X-Proofpoint-GUID: v8FYzaZyvPO3g1OiK2E9EL9_gWvOK1Tp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180051



> On 17 Mar 2026, at 9:34=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Sat, Mar 14, 2026 at 1:37=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>> Perf test perftool-testsuite_probe fails as below:
>>=20
>> Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on =
inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added =
probe :: perf probe -l (output regexp parsing)
>> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple =
probes
>> Regexp not found: "probe:vfs_mknod"
>> Regexp not found: "probe:vfs_create"
>> Regexp not found: "probe:vfs_rmdir"
>> Regexp not found: "probe:vfs_link"
>> Regexp not found: "probe:vfs_write"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding =
support (command exitcode + output regexp parsing)
>> Regexp not found: =
"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>> Regexp not found: "in this function|at this address"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing =
variable (output regexp parsing)
>> ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures =
found
>>=20
>> Further analysing, the failed testcase is for "test_adding_kernel".
>> If the kernel debuginfo is missing, perf probe fails as below:
>>=20
>> perf probe -nf --max-probes=3D512 -a 'vfs_* $params'
>> Failed to find the path for the kernel: No such file or directory
>>  Error: Failed to add events.
>>=20
>> skip_if_no_debuginfo has check to handle whether debuginfo is present
>> and the testcase checks for debuginfo since this :
>> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
>> testcases fail when kernel debuginfo is not present")
>>=20
>> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
>> via this another fix:
>> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no =
suitable
>> line detected")
>> Since this commit, first add_probe_vfs_getname is used to prevent =
false
>> failures. And based on return code of add_probe_vfs_getname, =
skip_if_no_debuginfo
>> is used to skip testcase if debuginfo is present. And this modified =
other
>> testcases to call add_probe_vfs_getname first and invoke
>> skip_if_no_debuginfo based on return value.
>>=20
>> The tests in test_adding_kernel.sh which depends on presence of
>> debuginfo are:
>> 1. probe add for inode_permission
>> 2. probe max-probes option using 'vfs_* $params'
>> 3. non-existing variable probing
>>=20
>> For these tests, probe check for specific line is not required.
>> So call skip_if_no_debuginfo with argument to say if line check is
>> needed. This is to convey to skip_if_no_debuginfo() function
>> that test only needs to check for debuginfo, and not specifically
>> line number. Update skip_if_no_debuginfo to use simple "perf probe"
>> check if test only needs to check for debuginfo. And for other
>> tests which rely on line number, use add_probe_vfs_getname()
>>=20
>> With the change, verified that only three which required debuginfo =
only
>> is skipped and others ran successfully. Also tested with debuginfo
>> to make sure tests are not skipped.
>>=20
>> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Thanks for taking the time to improve the test pass rate! I'm sure you
> saw Venkat's comments, but for the change itself:
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
>=20
> Thanks,
> Ian

Thanks Ian for the review.=20
Sure, I will address Venkat=E2=80=99s comments along with your =
Reviewed-by in V2

Thanks
Athira
>=20
>> ---
>> .../tests/shell/base_probe/test_adding_kernel.sh  | 15 =
++++++++++++++-
>> tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>> 2 files changed, 26 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh =
b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> index 555a825d55f2..f3db125c8669 100755
>> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> @@ -23,10 +23,23 @@ TEST_RESULT=3D0
>> . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>>=20
>> TEST_PROBE=3D${TEST_PROBE:-"inode_permission"}
>> +PROBE_NO_LINE_CHECK=3D1
>>=20
>> # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>> # skip_if_no_debuginfo returns 2 if debuginfo is not present
>> -skip_if_no_debuginfo
>> +#
>> +# The perf probe checks which depends on presence of debuginfo and
>> +# used in this testcase are:
>> +# 1. probe add for inode_permission
>> +# 2. probe max-probes option using 'vfs_* $params'
>> +# 3. non-existing variable probing
>> +#
>> +# For these tests, probe check for specific line is not
>> +# required ( add_probe_vfs_getname does that ). So call
>> +# skip_if_no_debuginfo with argument as 1. This is to convey
>> +# that test only needs to check for debuginfo, and not specifically
>> +# line number
>> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>> if [ $? -eq 2 ]; then
>>        NO_DEBUGINFO=3D1
>> fi
>> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh =
b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> index 88cd0e26d5f6..8584ec76f041 100644
>> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>> }
>>=20
>> skip_if_no_debuginfo() {
>> -       add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find =
the path for the kernel|Debuginfo-analysis is not supported)|(file has =
no debug information)" && return 2
>> +       no_line_check=3D$1
>> +       debug_str=3D"^(Failed to find the path for the =
kernel|Debuginfo-analysis is not supported)|(file has no debug =
information)"
>> +
>> +       # search for debug_str using simple perf probe if the
>> +       # test only needs to check for debuginfo, and not =
specifically
>> +       # line number.
>> +       if [ $no_line_check -eq 1 ]; then
>> +               perf probe -v -L getname_flags 2>&1 | grep -E -q =
"$debug_str" && return 2
>> +       else
>> +               add_probe_vfs_getname -v 2>&1 | grep -E -q =
"$debug_str" && return 2
>> +       fi
>> +
>>        return 1
>> }
>>=20
>> --
>> 2.47.3


