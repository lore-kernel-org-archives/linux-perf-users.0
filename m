Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34224676D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272250; cv=none; b=VX2D9UCdzNc24C1wBFSgv5nWmHBWbuo+FONxfbfCgGXXzEPDlZUNrYn7UN7opJcqTkBQuR/iF2A1CfVscrnWdWbv/sifzZ+WQK6EFjz8QtFUvP05CcKkHmMtyeFUr24hxF/XB8fLUVzUaaD3uBMwQeKzbBWmJSdtu5jRureETL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272250; c=relaxed/simple;
	bh=6cJ/Gj8TrXe01z2Yp965Z2DR+v1/NFeJiNHffYf96/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cqJU444HNvceMk/mWfhFRS0+82rFW8jF2dQQmvtNt3Cs87MeV/3HZBTCRYYNX2vASm1W6DZpZ+OMXAa3xS57YvAMQdjP8hgtOwe7lk1t+UYpYj9nYCWXIFnv0Nplk9ckymEIv94t8f89Q71shXnay8dK9MTL4aA5mK1iOWMAHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kiRqxa42; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kiRqxa42"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R5YvwC584793;
	Mon, 27 Apr 2026 06:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFs/+S
	O0NRdI8sfQelYmqfDL7iSOEjFuente3HGsLak=; b=kiRqxa42NRaC7N8CBJUHJg
	eeCGu/cJRJblqjRkGoNk5WeF6tKFQEeaNRlRldvALWHF2YIUHh1hAnYhmI8IXs75
	iLsvmTJ4G1jaER5JODo/1O9PXteNddvFijHHo1oF9k7pvYLiXaUu9RLMuWR4KTWB
	0qNnEEBdMxxIS7Q4sBlbG2qG9TrHPDQPXT5p1BcSMu1wniKaHH62mdHzXValEfdl
	qNgw30Ehq8jZGOJ/4PvvE8Ckew87xeeH4r8Dh8FkgxnnydyG612CcGcgRx6zt5Mj
	URXj/pi80yabfaXfuifZkxT91oK0y0ra6DXAOXNlGpYkVGiK2Bx3U3izOyFhouWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qy17x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 06:43:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R6cpMK005884;
	Mon, 27 Apr 2026 06:43:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g3u4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 06:43:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R6hsv814615088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 06:43:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC8758062;
	Mon, 27 Apr 2026 06:43:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B290958055;
	Mon, 27 Apr 2026 06:43:49 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.240.24])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Apr 2026 06:43:49 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260426093930.47809-1-atrajeev@linux.ibm.com>
Date: Mon, 27 Apr 2026 12:13:36 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3D252E5-528C-4BAD-918B-019FEBAF1FA1@linux.ibm.com>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KXS8qzrwiyW76t5UYD_xPsskatCRYP_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NSBTYWx0ZWRfXzP+tSAGd7q4O
 KdTd93OAb+dVfZgmVNGqtgAHqto7hqEVsq7dEWGg2ttn5TvtGgruq2+M1delg1b/B2gjondww78
 oIFIDFF9oIjHbfIvFtx/y+cJirwExHXbTHpyqrZZH2pY6t8Q7md0kDYacDfb/qmrGTcALba2s3G
 r69YD5L/yj05FfyolkiyCFtdr77zImsXf8kIGEMa43ci0Pj7LDJtottz/5XdNM5hQl0CveseH9m
 0ezzcHD2bGThM9IbXDqq4xVovbIliOoQ8CDemTenst/xNEhm156a/H8H6nmQqKd8d8n0VDk+EQA
 rSuHUYpS+tj7l0EpWN0jtDUQLXqnQ01qlyTmkeW768048ycRiW/WdANBp6ppPdAOBWou8oJEskx
 8QgxbNcYBABzmQsIKZc/a6hZ2ONLp50VMXYdLJVw1jBJj+bqUbJnlRuyllGkRROFJFTyRV92XkG
 cJvNVWR03HEKKe3gx3A==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef05ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x5QCPqNzQhPJdF4W:21 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=rtiepFT_uq_YKlmCwo4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XUngkgV6DXmt6tFHEB2xAgSlJ73PC-5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270065



> On 26 Apr 2026, at 3:09=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> In redhat perftool testsuite, observed fail for this test:
>    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary =
(output regexp parsing)
>=20
> This led to analysis of "perf sched timehist" summary options.
>=20
>  # perf sched record -a -o ./perf.data -- sleep 0.1
>   This will record using perf sched record
>=20
> perf sched timeliest has two options "-s" and "-S"
>  # perf sched -i ./perf.data timehist -S
> -S : Captures summary also at the end
>=20
>  # perf sched -i ./perf.data timehist -s
> -s : Captures only summary
>=20
> The test saves -s result which has only summary and compares with
> summary which comes at the end from -S . Since there is a difference
> in these two, test fails.
>=20
> Checking the behaviour change in -S and -s results, difference is:
>=20
>                  rcu_sched[16]       2          4        0.013      =
0.001       0.003       0.006   33.23       0
>               migration/11[73]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>                migration/3[33]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
> -               :216753[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
> +                 sleep[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
>                migration/8[58]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>            NetworkManager[811]       1          2        0.089      =
0.028       0.044       0.060   36.06       0
>               migration/13[83]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>=20
> Here 216753 is pid for sleep which is a zombie process. This is
> happening in latest kernel due to an update in "-S" result.
> In -S, the process name appears in the results "sleep[216753]",
> where as in the -s, only pid is present in the summary result
> ":216753[216753]".
>=20
> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
> of processes in zombie state")
> for -S option, if process name is using pid, it uses different way to
> set it. So that we get the process name and not just Pid.
>=20
> This change went in only for timehist_print_sample() function.
> Add this improvement in generic place so that even -s option (which
> captures summary) also will have meaningful information.
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---

Tested this patch, by applying on top of mainline kernel.

WithOut Fix:

# ./perf sched -i perf.data timehist -s
Samples of sched_switch event do not have callchains.

Runtime summary
                          comm  parent   sched-in     run-time    =
min-run     avg-run     max-run  stddev  migrations
                                          (count)       (msec)     =
(msec)      (msec)      (msec)       %
=
--------------------------------------------------------------------------=
-------------------------------------------
              migration/14[88]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
               migration/6[48]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
               rcu_preempt[16]       2          7        0.042      =
0.003       0.006       0.014   23.80       0
              migration/11[73]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
               migration/3[33]       2          1        0.009      =
0.009       0.009       0.009    0.00       0
          sshd-session[384033]   384025          4        0.104      =
0.023       0.026       0.032    8.14       0
       kworker/u68:3-e[316378]       2          1        0.003      =
0.003       0.003       0.003    0.00       0
               kcompactd3[114]       2          1        0.003      =
0.003       0.003       0.003    0.00       0
               migration/8[58]       2          1        0.012      =
0.012       0.012       0.012    0.00       0
              migration/13[83]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
               migration/5[43]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               migration/0[19]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
              migration/10[68]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               ksoftirqd/5[44]       2          1        0.184      =
0.184       0.184       0.184    0.00       0
               migration/2[28]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
       kworker/4:0-mm_[383676]       2          1        0.013      =
0.013       0.013       0.013    0.00       0
                  perf[390116]   384034         17        0.065      =
0.000       0.003       0.065   100.00       0
             xfsaild/dm-2[861]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
              migration/15[93]       2          1        0.009      =
0.009       0.009       0.009    0.00       0
               :390117[390117]      -1          1        0.124      =
0.124       0.124       0.124    0.00       0
       kworker/9:4-mm_[390101]       2          1        0.069      =
0.069       0.069       0.069    0.00       0
               migration/7[53]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
       kworker/5:0-xfs[390077]       2          1        0.015      =
0.015       0.015       0.015    0.00       0
              migration/12[78]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               migration/4[38]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
           NetworkManager[903]       1          4        0.275      =
0.032       0.068       0.105   29.66       0
               migration/1[23]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
               migration/9[63]       2          1        0.011      =
0.011       0.011       0.011    0.00       0



With FIX:

# ./perf sched -i perf.data timehist -s
Samples of sched_switch event do not have callchains.

Runtime summary
                          comm  parent   sched-in     run-time    =
min-run     avg-run     max-run  stddev  migrations
                                          (count)       (msec)     =
(msec)      (msec)      (msec)       %
=
--------------------------------------------------------------------------=
-------------------------------------------
              migration/14[88]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
               migration/6[48]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
               rcu_preempt[16]       2          7        0.042      =
0.003       0.006       0.014   23.80       0
              migration/11[73]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
               migration/3[33]       2          1        0.009      =
0.009       0.009       0.009    0.00       0
          sshd-session[384033]   384025          4        0.104      =
0.023       0.026       0.032    8.14       0
       kworker/u68:3-e[316378]       2          1        0.003      =
0.003       0.003       0.003    0.00       0
               kcompactd3[114]       2          1        0.003      =
0.003       0.003       0.003    0.00       0
               migration/8[58]       2          1        0.012      =
0.012       0.012       0.012    0.00       0
              migration/13[83]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
               migration/5[43]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               migration/0[19]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
              migration/10[68]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               ksoftirqd/5[44]       2          1        0.184      =
0.184       0.184       0.184    0.00       0
               migration/2[28]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
       kworker/4:0-mm_[383676]       2          1        0.013      =
0.013       0.013       0.013    0.00       0
                  perf[390116]   384034         17        0.065      =
0.000       0.003       0.065   100.00       0
             xfsaild/dm-2[861]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
              migration/15[93]       2          1        0.009      =
0.009       0.009       0.009    0.00       0
                 sleep[390117]      -1          1        0.124      =
0.124       0.124       0.124    0.00       0
       kworker/9:4-mm_[390101]       2          1        0.069      =
0.069       0.069       0.069    0.00       0
               migration/7[53]       2          1        0.008      =
0.008       0.008       0.008    0.00       0
       kworker/5:0-xfs[390077]       2          1        0.015      =
0.015       0.015       0.015    0.00       0
              migration/12[78]       2          1        0.007      =
0.007       0.007       0.007    0.00       0
               migration/4[38]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
           NetworkManager[903]       1          4        0.275      =
0.032       0.068       0.105   29.66       0
               migration/1[23]       2          1        0.010      =
0.010       0.010       0.010    0.00       0
               migration/9[63]       2          1        0.011      =
0.011       0.011       0.011    0.00       0

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
> tools/perf/builtin-sched.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..ee1b89a6af50 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2197,11 +2197,6 @@ static void timehist_print_sample(struct =
perf_sched *sched,
> printf(" ");
> }
>=20
> - if (!thread__comm_set(thread)) {
> -                const char *prev_comm =3D evsel__strval(evsel, =
sample, "prev_comm");
> -                thread__set_comm(thread, prev_comm, sample->time);
> -        }
> -
> printf(" %-*s ", comm_width, timehist_get_commstr(thread));
>=20
> if (sched->show_prio)
> @@ -2890,6 +2885,15 @@ static int timehist_sched_change_event(const =
struct perf_tool *tool,
> itr->last_thread =3D NULL;
> }
>=20
> + /*
> + * If the process name is not set for the thread, use "prev_comm"
> + * to set it. Otherwise the sched summary will have just pid =
information
> + */
> + if (!thread__comm_set(thread)) {
> + const char *prev_comm =3D evsel__strval(evsel, sample, "prev_comm");
> + thread__set_comm(thread, prev_comm, sample->time);
> + }
> +
> if (!sched->summary_only)
> timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> }
> --=20
> 2.47.3
>=20

