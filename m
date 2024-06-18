Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0A156F5A;
	Tue, 18 Jun 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702824; cv=none; b=EiTCG8goja0vknkIVwufAwwbFlYRB8/AAn+PjrfIUXzcW5N3MONRuDWs2U7CIY7QW8+VN2w3n7ZGMYU7pZjQXC2TEPjxvBwoUvElw7Mgqyd+WTMkAB6L87fmLvVc1xwx6eoquXyjsSezONYQwzklhRYUz3umCy6GYb3lQhjCG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702824; c=relaxed/simple;
	bh=PcajFIfU/lfXMPheHFBuXTAxzTOMhduVTF1NXCiR94o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OhhaHOLFWoMNjcn3R7i/U39yyM/zAOwcAx/CPMiQ/ZVbzRS1takD87XLsCdT+qXiMtPptBTMHgGEkb/P/RC9BPP+Sl0b2bTp+oYHkAHYJaEWsF9alYLF+3d08cj5+7iQTtJ/dDW3BJs5SZwrXXEfdJY1/3YYspy4MXTtLzeT1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anC5IXNK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anC5IXNK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I9Qo12016215;
	Tue, 18 Jun 2024 09:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=W
	HPf+VF+DDwlyBlNY4mXd16OByOTb4uw2IrfouiXYKo=; b=anC5IXNKNLQzPJOgi
	I+wul+ETRTUkHzQPv9qzLkXBJgrMnUwdrILremB5kKEnVj8kG8XrsP5k5297DTz2
	Ya9A6ad+Yxv7SBaZPHwObaNWl5xUWj/1GB2I+EsoTOS1NITgC8T32vIIoql3uw1s
	pgkQqPpZzxaQmGQB+KsLeXzXUohfCcuW3CgiisX9mAFzJULHTk7n9juKvI5agcSR
	4o4Q44sO1l5fvcb4DeNdhukCJv5X2cAoUGa+mXnGuRK4Gcv0nFg//o6pr9pis5Gh
	bN4jC2KMTfDyl4LXzfJvfrEHAKv2KoZpJq5OIqNItIdwtp9qWIs1FZ8vQwlLLuxW
	IdJAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4ja8f6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:26:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I9QrDb016334;
	Tue, 18 Jun 2024 09:26:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4ja8f6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:26:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45I7Qc5G011031;
	Tue, 18 Jun 2024 09:26:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsn1e7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:26:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45I9Qks433620620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:26:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FFA420043;
	Tue, 18 Jun 2024 09:26:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B52320040;
	Tue, 18 Jun 2024 09:26:44 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.84])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Jun 2024 09:26:44 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH V2 2/3] tools/perf: Use is_perf_pid_map_name helper
 function to check dso's of pattern /tmp/perf-%d.map
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <223d1e96-223f-4bda-8133-806a3aa61730@intel.com>
Date: Tue, 18 Jun 2024 14:56:32 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5A7F119-DC65-4439-B856-F7D1DE9E3F97@linux.vnet.ibm.com>
References: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
 <20240617130332.13427-2-atrajeev@linux.vnet.ibm.com>
 <223d1e96-223f-4bda-8133-806a3aa61730@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l-ab5PnGqrq_VEqlZKtCu1kn4mjUgglb
X-Proofpoint-ORIG-GUID: oc8RMytrds2jta0hyO5Y27ghPQKnae6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406180069



> On 18 Jun 2024, at 12:41=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
> On 17/06/24 16:03, Athira Rajeev wrote:
>> commit 80d496be89ed ("perf report: Add support for profiling JIT
>> generated code") added support for profiling JIT generated code.
>> This patch handles dso's of form "/tmp/perf-$PID.map".
>>=20
>> Some of the references doesn't check exactly for same pattern.
>> some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
>> this by using helper function is_perf_pid_map_name which looks
>> for proper pattern of form: "/tmp/perf-$PID.map" for these checks.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/dsos.c    | 2 +-
>> tools/perf/util/srcline.c | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
>> index ab3d0c01dd63..23cd02aa701d 100644
>> --- a/tools/perf/util/dsos.c
>> +++ b/tools/perf/util/dsos.c
>> @@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
>> char *base, *lname;
>> int tid;
>>=20
>> - if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) =3D=3D 1) =
{
>> + if (is_perf_pid_map_name(dso__long_name(dso))) {
>=20
> Perhaps add another helper for this case:
>=20
> bool perf_pid_map_tid(const char *dso_name, int *tid)
> {
> return sscanf(dso_name, "/tmp/perf-%d.map", &tid) =3D=3D 1;
> }
>=20
> bool is_perf_pid_map_name(const char *dso_name)
> {
> int tid;
>=20
> return perf_pid_map_tid(dso_name, &tid);
> }
>=20
> And then:
>=20
> if (perf_pid_map_tid(dso__long_name(dso), &tid)) {
>=20
>=20

Hi Adrian

Thanks for suggestions. I will be posting V3 soon.

Athira
>=20
>> if (asprintf(&base, "[JIT] tid %d", tid) < 0)
>> return;
>> } else {
>> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
>> index 9d670d8c1c08..51eb78993fe2 100644
>> --- a/tools/perf/util/srcline.c
>> +++ b/tools/perf/util/srcline.c
>> @@ -39,7 +39,7 @@ static const char *srcline_dso_name(struct dso =
*dso)
>> if (dso_name[0] =3D=3D '[')
>> return NULL;
>>=20
>> - if (!strncmp(dso_name, "/tmp/perf-", 10))
>> + if (is_perf_pid_map_name(dso_name))
>> return NULL;
>>=20
>> return dso_name;
>=20

