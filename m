Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CC274B26
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428585; cv=none; b=ta2AdKDcp7b4LzbQ5es7iQuclwbpmHy/YOcnv3Siia6BICbVJV2gh10tC+PhQ0zrJV5yEQf2rN/Aq+yG6fTiGk9fbn8/SXPB4HEG5Nd3yEkEDtNAIXtPePoor7keqH6pWJag7UNxxhKiwYxSMnrjoCGQrcNSdacQXj5PEe0Z1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428585; c=relaxed/simple;
	bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0HVJFQmYecD0Rk6gdIH8A6LBR8agnpgPT7LGgdcLbrIwJp41lnMtD+3ks5QIEezXZ81wU+GPSXXllS2bHaESP8hceMKFCZjQm50znOMI3TIQ/ElkyERZVMo5XgB0NzCQezTs0YCUT6rzDqwpjzXL2qkHv0MdsR7dz7umnL/UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5bEcIVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5bEcIVn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929TIu4005570
	for <linux-perf-users@vger.kernel.org>; Thu, 2 Oct 2025 18:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=; b=V5bEcIVnpEEGSW/K
	sswMJNBXvlTgsDi0tXuhJnoWZcHHhYt6TaH/F7svLIzzs9tWuFhizbWjettpnoN8
	3OP6TYD9t9fP5dtbI234ciJJskTjhipA4pOHGMhGTZqgjACRjq83/3uwcPDto74X
	G2LFep8V4Rx5cVk6CSFtAmgV1cSwpAmmPbwLrrM74k6QWDHmS9LtdbQwfXVeCaI8
	P6nky/iaAtcsH8d4JzBx0zNj3yqOPXZUZ5qM6Hd50wV7G67sxW70M6JBEJjw3qcy
	EHAlRKuIVhl+eLU5nKN8Cbr89wqtW39rFbVEE73tUaYtmET2OnvuSUVM59XdzIdV
	jO8SvQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851rmd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 18:09:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6fc6so27809765ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 11:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428582; x=1760033382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
        b=DrMUjtuKloXU97vt3QzdNAwyKYVrmzY88LTCm45VLCw8xYUCniw07ShO5BKpQB781r
         BufW/sFLhUFutHCmeRt9O9Rvjbi8N+movKqFnMDqy3h8gz+UG3usDtn2q3ztlfFxNbBE
         d8oOGNI8Z46QCJYGwCOjSt1m/wcoaBYgZNTVPpn5cBOOvyJtxpnvDBIM5DsubDyQzHeC
         P7817MsPl4WVTI667p9gMpcAgiUPptXU0SHgaAvGb2FTiTUvC1w56EK0bdeSzTT5u7rc
         g8Y72RIVYEWQDbW2AQvo+7PYz9a6eGq85OPZdqYl7YdkD8CdvdFxS7Ou/khUbYPrGFDC
         ZHFg==
X-Forwarded-Encrypted: i=1; AJvYcCXGxxGloLNnN94YCJY29dbL5B7+066UFpSxx2b8lGn+5sR3wwYzjKNmuauOYoSwxwRS0oTvGltNxDFZouGbg3vl@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxh1f1jkF/Nq50Y3EcHtpY+UVmq6X7SJWUuZsLg+owc2k6eBh
	YwrHrQsjqYpGZvd+6LFP5NmjPUPw5SVQS1XxJV2Fs+TDIvqjXH26eETKLdZVO2Hn/ytWJ2OJnDQ
	yIqdkuTrxhe4nM5ehLsNTyvZ9mlj4cACgqh0glL+xs3L6HdVbHS5mAOasC1tNX+O9/xpiyneWsT
	hXoYMFvGvVoQ6BnduYcUF210pwRv7Q9N7sGopiBNy5bAoFyLc=
X-Gm-Gg: ASbGncvT2nCQxe8iqea0bbr3I9BpguOzyEthLtwbKJh6ulrGlpUMi3jFqJKUPQ/o2FM
	xrdkJmcdr0yxJePLPDzxHrykQHUfL/7kn/CLrftNywxrco0ZNwbn/BM+YXAt9DNOzSxpMJVKje/
	55lkA1TPnTtTv5m/27ezbwlIQno38=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-28e9a7031c4mr1578965ad.61.1759428580628;
        Thu, 02 Oct 2025 11:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp+nzr4kOaiK9pHKoBe7y+pNgMV1+KMM5h/aSQpFMdxD2b/L9xkPrqEo1lFclOnfCQtSnXjjCgAmMou37yiBw=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-28e9a7031c4mr1578615ad.61.1759428580113; Thu, 02 Oct 2025
 11:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com> <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev> <aN629m1MlMXYh1te@x1>
 <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
 <aN69RSQQ8agXOBDH@x1> <87wm5dtc7q.fsf@gentoo.org>
In-Reply-To: <87wm5dtc7q.fsf@gentoo.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:09:28 -0700
X-Gm-Features: AS18NWBnpmJoQOPbNXZCG7gxNfGYH9tAmT0-_sb-ZrHu9aZmPY32BVGyYsUoNW8
Message-ID: <CALvbMcC3fT8sz=45Ncf_Lydyyas57Jje-erLBKTaM-m87+jbLQ@mail.gmail.com>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC compatibility
To: Sam James <sam@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Pinski <apinski@quicinc.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68debfe7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nzY_nJytDTGGSvjW54AA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=wa9RWnbW_A1YIeRBVszw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX7HTZ3ZannIzC
 /yG4D1k8CaMUfuMhIIPO2pSR75uJTrhMV9HJyecJU3qmPV/2h6u+cBp4md5349v7rm9Zu+U+VJe
 7qND2DdwdbYgU/2B/6/dLhQbrxbRLWwlntkB6a9l5Gyh2JPfUyVpdxmkB9AlcgxPACoZxBULEt7
 FBVQJ+ViXdFUN9e1ldU+4WPqVnT2uE6CaRbNNf9R2ZJcu+bi1EIIt2crH8+PjAwfgYpnf1WNy3V
 DaARuQ9vN2NkRbEIJER8hMRZ6dbtbwpkjS2INedxIXnmbgTAfKGIZ1fOr3rY9f908hQqnxCDYfT
 MPC4egsS5dyiLxtJcXaVlt0syrmYyv5/YrUml4bh1ko0Q41IkCrWSf4veq1OU7OKCG/TypQ3UkB
 4ycjRPiOznSLK/m5hMTmc3NmmIJ6PQ==
X-Proofpoint-ORIG-GUID: La7nOupO6MKtHkkkXi454SofVjdEgDhX
X-Proofpoint-GUID: La7nOupO6MKtHkkkXi454SofVjdEgDhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Thu, Oct 2, 2025 at 11:01=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> > On Thu, Oct 02, 2025 at 05:35:09PM +0000, Andrew Pinski wrote:
> >> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> > So I'm taking the patch as-is, ok?
> >
> >> > But first we need the Signed-off-by tag from Andrew Pinski as
> >> > he is listed in a Co-authored-by, that I replaced with Co-
> >> > developed-by as its the term used for this purpose in:
> >
> >> > Yonghong, can I add an Acked-by: you since you participated in
> >> > this discussion agreeing with the original patch (If I'm not
> >> > mistaken)?
> >
> >> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> >
> >> Note my email address for doing Linux and GCC development is
> >> Andrew.pinski@oss.qualcomm.com . It was apinski_quic@quicinc.com but
> >> that changed last month.
> >
> > This is what I have in the patch now:
> >
> > Co-developed-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
>
> Looks good if Andrew is happy. Thanks!

I am.

>
> >
> > - Arnaldo
