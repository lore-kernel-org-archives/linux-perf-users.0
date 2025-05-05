Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7702063F0;
	Mon,  5 May 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445813; cv=none; b=U2Y8uPlbONp2U7tNR/BeMZLudVfwiB9twFk5oXhxqRBNQLhwIbDNZbhlOhc6oIIpU7WWqXSxvafex8HDnd85nzQ02Nc1PvNjj6muo3mJ4ifEZnlpCJJ6TU/63nBAyfKRgpJr1WSpbXzCvc8m6WFyz6MzC9uYCM85gpFmfV5BUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445813; c=relaxed/simple;
	bh=qQexBfIZsy8yop5EiW0+JAI8tUBYSzoNr18NJ7Z56w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKIuNQZ75u8zSmRSXL4sGIf/lz/1zxDt0bo7znjPlz0iKWEEaRdNF4q3Lz4Zc5yuwxtcDCqml9dnd96WdDFABLNtDWdcjlhaXLGbErW5gQMq+Pnrut903BFgyt3cpSgS5GPVSj6g6XKBu8vAUIY2gsZbNkQj0o6I0WucSy+9pjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S92r8YRB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S92r8YRB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5453iIan017516;
	Mon, 5 May 2025 11:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NAW+FJ
	NyjFqwtJqZzMOnDM3E2VP8rF2PoFWySRO3URg=; b=S92r8YRBxAnfsjn2iN0dpN
	2pjQFzZnj0IWzevPoOONHk3ByWCVxcoOxgz98RsFpIU61VSpaNQt4Wv9UC5gOVnC
	CkFT0smnrEqWgNf49zRXZaAStWL94AcOmsl5Yb8oHUyPIN2kj7qJGvalOKTEGfPt
	VOHyGh/bbcA8sURwU5MExkBqQNbi9hLblB+ADcy3uUdYpiQmZrC261A/hrkD9Re4
	aS8aVwZU4C/GyNtXIzQDT252MdD7WMfBVSavUdwn/6ysPBzMrz3B58/7CM+ze1bT
	81Spm0d44Hq3ZulSolyMiESntADd/7HrCNBv6xB4pvh/5LEzLwMZ14Us4q+Y9fUA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eftkjsvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:49:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 545BUCvd020358;
	Mon, 5 May 2025 11:49:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eftkjsvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:49:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5459k2O8013880;
	Mon, 5 May 2025 11:49:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e0625pb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:49:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 545BngPp36241730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 11:49:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EB6B20049;
	Mon,  5 May 2025 11:49:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECAF20040;
	Mon,  5 May 2025 11:49:39 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.223.112])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 May 2025 11:49:39 +0000 (GMT)
Date: Mon, 5 May 2025 17:19:34 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com
Subject: Re: [PATCH 3/4] perf python: Add evlist close and next methods
Message-ID: <wu4cq5jilwtwdle2xuj5vuzz2cc6hx4whrbshkiw2pregk4xdi@lj7i53kssgur>
References: <20250501093633.578010-1-gautam@linux.ibm.com>
 <20250501093633.578010-4-gautam@linux.ibm.com>
 <CAP-5=fX1qodprWrwK7yq2WYZNnLtiEe_rjvw0aJ7gXY2ma+Hzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX1qodprWrwK7yq2WYZNnLtiEe_rjvw0aJ7gXY2ma+Hzw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMSBTYWx0ZWRfX623FoS93JY6N j0Wymi06tOIr/07dp5Zg6tixKohVEpt8S67YHgmHXGL8RT5ykFRSE/DDKU5YYKKmFNIa8y7tT2h pdoJdG0diAdpSz0ttKbLMxIp7GU5a+CDM0TISRY9RtKhhFY+HwLIpO8KYMDY1MiWSuGnnKsR21V
 QxpFsgIRg78l5MPQTZpCyTdIX/iYZ880CVmNqmW833LigGNLE35MC8nxy6z9JAyTW1lTiSJdhyc 5Xm3KG+tcGldw14kgn+oaNfMKMMYy5vC3ZE5b5/vOL4IhMoeRkEnyeFoKs6Bid5ok6sCUqEfz0+ 06Nwf3vdFZYVBayTm/mI/LE/OCeBy+kMajRlwCNsBv0Po8jFC43eWdESEsB8JSMsAn2abnR6blR
 9TQ3Cx627IXpSMDlpsKMEIkmrd5isXM0JUQIfLrTCr6TXiEUJGzFZcoNqXowdHbOLZSeElO7
X-Proofpoint-GUID: bn9S-77Tu2AjFxpd8gRXjQGJQZer1yzW
X-Authority-Analysis: v=2.4 cv=Q7vS452a c=1 sm=1 tr=0 ts=6818a5d9 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=xCs7A96TP6Cw99lmuhcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _qiyHADQZzXP0T4p6v3YZPU6F1W5NiFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050111

On Thu, May 01, 2025 at 08:49:08AM -0700, Ian Rogers wrote:
> On Thu, May 1, 2025 at 2:37 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
> >
> > Add support for the evlist close and next methods. The next method
> > enables iterating over the evsels in an evlist.
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  tools/perf/util/python.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 5a4d2c9aaabd..599cb37600f1 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1163,6 +1163,16 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
> >         return Py_None;
> >  }
> >
> > +static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
> > +{
> > +       struct evlist *evlist = &pevlist->evlist;
> > +
> > +       evlist__close(evlist);
> > +
> > +       Py_INCREF(Py_None);
> > +       return Py_None;
> > +}
> > +
> >  static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
> >  {
> >         struct record_opts opts = {
> > @@ -1202,6 +1212,31 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
> >         return Py_None;
> >  }
> >
> > +static PyObject *pyrf_evlist__next(struct pyrf_evlist *pevlist,
> > +                                  PyObject *args, PyObject *kwargs)
> > +{
> > +       struct evlist *evlist = &pevlist->evlist;
> > +       PyObject *py_evsel;
> > +       struct perf_evsel *pevsel;
> > +       struct evsel *evsel;
> > +       struct pyrf_evsel *next_evsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
> > +       static char *kwlist[] = { "evsel", NULL };
> > +
> > +       if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O", kwlist,
> > +                                        &py_evsel))
> > +               return NULL;
> > +
> > +       pevsel = (py_evsel == Py_None) ? NULL : &(((struct pyrf_evsel *)py_evsel)->evsel.core);
> > +       pevsel = perf_evlist__next(&(evlist->core), pevsel);
> > +       if (pevsel != NULL) {
> > +               evsel = container_of(pevsel, struct evsel, core);
> > +               next_evsel = container_of(evsel, struct pyrf_evsel, evsel);
> > +               return (PyObject *) next_evsel;
> > +       }
> > +
> > +       return Py_None;
> > +}
> > +
> 
> Thanks for this! Have you looked at the existing iteration support?
> There's an example here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/python/tracepoint.py?h=perf-tools-next#n26
> ```
>     for ev in evlist:
>         ev.sample_type = ev.sample_type & ~perf.SAMPLE_IP
>         ev.read_format = 0
> ```
> In the next patch you have:
> ```
>         evsel = evlist.next(None)
>         while evsel != None:
>             counts = evsel.read(0, 0)
>             print(counts.val, counts.ena, counts.run)
>             evsel = evlist.next(evsel)
> ```
> I believe the former looks better. It also isn't clear to me if next
> belongs on evlist or evsel.

Yes, the existing support would be the right way, I missed that. Will fix in
v2.

and regarding the next() function, I think we should keep it for evlist
because for the C code it's defined in the context of evlist, so would
avoid confusion. But since it is not needed for the iteration, should
I keep it in v2?

Thanks,
Gautam
