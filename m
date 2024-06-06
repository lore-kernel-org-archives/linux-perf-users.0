Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2D194AE1;
	Thu,  6 Jun 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669360; cv=none; b=J0/KkKBjSdixHd6QHTlJYVAGu05ABQU895H0QG3ZS9zoDOsiJXzeaJl7eZhK+f9bWghxwKUztOXeQTQuIxn/1Mv8/N6Du5q7lv/Sd8yz859FtV6MA5fmyE3pY/j7TSesgUzBMQeZKWIHpZ8FxU7ud5xjesNy3Ijus/uqqHKeJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669360; c=relaxed/simple;
	bh=zq7TxcJGz51RjT9nfUQibMh8LKejFtAFG5TFcvPutl4=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=TofeMTa9O5tghM53rcsqtMqhqRrsNFW7yUuhguTSrKlfPU6vTZM5rrjD8jDlrn3eMQhIJUS+5gjrS0UKjcYbrDkOxl8sC1xXm8ShwIXltquyDgU61/E4autqd4Cw5QeQGXXPgfggEfA4Z1sKgCdxKuoscOS/F0cPSnYGodEIB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLROtpF9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLROtpF9"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456AKC7I027841;
	Thu, 6 Jun 2024 10:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=379OOaBf5ORgK9NCimxk70AjpqXj00PeSO2vQUUoS+Y=;
 b=lLROtpF9+jJbdt+vYqnSnYxIKrUncnDT4VkwG8wPBRyOw/GgYklro7aYK8eX1iBCYt3h
 btD/wrt7v9z1JANYyE0cF8m3Z/nw2G++9iJRMjtasI83GbEj+dCsqDnbk5EBFeFotvq2
 SHbTN4Sgy2xoEUvr4t07f1OwsJZ0BQEWCZl8+/EI6uDnPLMlusE5qQnnZj4z35sshfn0
 so3OeP9ATLdgYc0r7vBdPoEFU45aViDZaa1DKXc3YDOhH5d+7mE4GTlPE0BEWUroqZHb
 h2OXgEfiLVA205nFhb0z8BVTw09GkUL+4PQvhc+sIc5h2kkxeFPrfpts30rIyBBx8n80 Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykav002fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 10:22:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456AMHam032160;
	Thu, 6 Jun 2024 10:22:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykav002fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 10:22:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45689YXY008479;
	Thu, 6 Jun 2024 10:22:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec125us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 10:22:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 456AMAMk43712872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Jun 2024 10:22:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED68420125;
	Thu,  6 Jun 2024 10:22:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899AA20122;
	Thu,  6 Jun 2024 10:22:07 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.84])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Jun 2024 10:22:07 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240417152521.80340-1-vineethr@linux.ibm.com>
Date: Thu, 6 Jun 2024 15:51:55 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-Id: <92D17E14-8565-4162-81C6-1ADA18AF48C2@linux.vnet.ibm.com>
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1CzpFPHbac3LN2eoW7yRzTdwR4b0QcJC
X-Proofpoint-ORIG-GUID: wr1FQ0oHqnoIC5-SfUSB5e3ZuuZzg03O
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060076



> On 17 Apr 2024, at 8:55=E2=80=AFPM, Madadi Vineeth Reddy <vineethr@linux.=
ibm.com> wrote:
>=20
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
>=20
> With --command-name option, one could specify the specific command
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific command. Since multiple
> PID's might have the same command name, using command-name filter
> would be more useful for debugging.
>=20
> For other tasks, instead of printing the symbol, ** is printed and
> the same . is used to represent idle. ** is used instead of symbol
> for other tasks because it helps in clear visualization of command
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
>=20
> 6.8.0
> =3D=3D=3D=3D=3D=3D
>  *A0                   213864.670142 secs A0 =3D> migration/0:18
>  *.                    213864.670148 secs .  =3D> swapper:0
>   .  *B0               213864.670217 secs B0 =3D> migration/1:21
>   .  *.                213864.670223 secs
>   .   .  *C0           213864.670247 secs C0 =3D> migration/2:26
>   .   .  *.            213864.670252 secs
>=20
> 6.8.0 + patch (--command-name =3D schbench)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   **  .   ** *A0       213864.671055 secs A0 =3D> schbench:104834
>  *B0  .   .   A0       213864.671156 secs B0 =3D> schbench:104835
>  *C0  .   .   A0       213864.671187 secs C0 =3D> schbench:104836
>  *D0  .   .   A0       213864.671219 secs D0 =3D> schbench:104837
>  *E0  .   .   A0       213864.671250 secs E0 =3D> schbench:104838
>   E0  .  *D0  A0
>=20
> This helps in visualizing how a benchmark like schbench is spread over
> the available cpus while also knowing which cpus are idle(.) and which
> are not(**). This will be more useful as number of CPUs increase.
>=20
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Tested the patch and looks good to me

Command to record: perf sched record sleep 5

With the patch, tested below and checked it filters and provides results fo=
r =E2=80=9Csleep=E2=80=9D and =E2=80=9Cperf=E2=80=9D

 perf sched map --command-name sleep
 perf sched map --command-name perf

Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:=
atrajeev@linux.vnet.ibm.com>>

Thanks
Athira
> ---
> tools/perf/Documentation/perf-sched.txt |  4 ++++
> tools/perf/builtin-sched.c              | 17 ++++++++++++++---
> 2 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documen=
tation/perf-sched.txt
> index 5fbe42bd599b..b04a37560935 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
> --color-pids::
> Highlight the given pids.
>=20
> +--command-name::
> + Map output only for the given command name.
> + (** indicates other tasks while . is idle).
> +
> OPTIONS for 'perf sched timehist'
> ---------------------------------
> -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0fce7d8986c0..e60836da53e5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,7 @@ struct perf_sched_map {
> const char *color_pids_str;
> struct perf_cpu_map *color_cpus;
> const char *color_cpus_str;
> + const char *command;
> struct perf_cpu_map *cpus;
> const char *cpus_str;
> };
> @@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
>=20
> sched->curr_thread[this_cpu.cpu] =3D thread__get(sched_in);
>=20
> - printf("  ");
> -
> new_shortname =3D 0;
> if (!tr->shortname[0]) {
> if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
> */
> tr->shortname[0] =3D '.';
> tr->shortname[1] =3D ' ';
> - } else {
> + } else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
> + sched->map.command)) {
> tr->shortname[0] =3D sched->next_shortname1;
> tr->shortname[1] =3D sched->next_shortname2;
>=20
> @@ -1618,10 +1618,18 @@ static int map_switch_event(struct perf_sched *sc=
hed, struct evsel *evsel,
> else
> sched->next_shortname2 =3D '0';
> }
> + } else {
> + tr->shortname[0] =3D '*';
> + tr->shortname[1] =3D '*';
> }
> new_shortname =3D 1;
> }
>=20
> + if (sched->map.command && strcmp(thread__comm_str(sched_in), sched->map=
.command))
> + goto skip;
> +
> + printf("  ");
> +
> for (i =3D 0; i < cpus_nr; i++) {
> struct perf_cpu cpu =3D {
> .cpu =3D sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1678,6 +1686,7 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
> out:
> color_fprintf(stdout, color, "\n");
>=20
> +skip:
> thread__put(sched_in);
>=20
> return 0;
> @@ -3560,6 +3569,8 @@ int cmd_sched(int argc, const char **argv)
>                     "highlight given CPUs in map"),
> OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>                     "display given CPUs in map"),
> + OPT_STRING(0, "command-name", &sched.map.command, "command",
> + "map output only for the given command name"),
> OPT_PARENT(sched_options)
> };
> const struct option timehist_options[] =3D {
> --=20
> 2.39.1
>=20
>=20

