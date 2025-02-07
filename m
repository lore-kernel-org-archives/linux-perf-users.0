Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B02A1D8
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949986; cv=none; b=IC+vJQIrMChRRwlsH9X2Tr29yiwFWuIdH1+uyu+vN2D+lTbg9iXiCtFsp8gMHvqKVUXPA5qh6czS9TpLfFY9FNj9hmu81eXp1oVjbBoRwlu6v4gDDUR1J9gbW8Ei2CoA0w6+9mpBoQ47CIajuGMatjcxrdbnGZhVNhNOzp1rWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949986; c=relaxed/simple;
	bh=DAwV0ZDD7XKfB/jVCkUNZ+6EmreX87Agu2Ytogu1Se4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EljZ+mDbQWnGcxQfSkcI5jyTYSBeJ8HDm0Qvvx4Ri7CwTnye44RQDsJiyVhBKmfyGqTqrgRe59OqH9lg31SEKioxhAJ+xukXhYEbUfyEfTT7cKMRMhfSfnfmgW4InhHw7J56Bq+QyjkmLKfJdHUDuu5MKlig9QGFrs8Hv9Ij4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miG2TfTH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miG2TfTH"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d147331fb5so1965ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738949984; x=1739554784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAwV0ZDD7XKfB/jVCkUNZ+6EmreX87Agu2Ytogu1Se4=;
        b=miG2TfTHk9zfSZV/Y93Oool7v9pbzvC37FjOnrVACv5k7q3lp6jz+ec+Drt1vAfxs9
         9Yb9Eap++Qb3Ui60RKgP7S/2aVUvTCVOUtLJHTGYyNuNvxVOb04JT2xi2q2Sn1mvFagA
         z2Bv60I8PlZsZMLfgV0ibeaPLxPr3EGbP2SY0cMC0ZF2hgoOQfXuL/rW9dtCNxc2eWBU
         yFZ0+71F9GZQgp898/zAr9N6EGtVwMt6SgZ+hc9RByW6AKzOLtm+5ioum9W/aIwnbvxO
         G7R+7/MSNT7rzo+aFTWyIITDifU50f9XFIrJ0L5gEkgMh4ZEmKBaVOqJFRbC0FrOcp4v
         evPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949984; x=1739554784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAwV0ZDD7XKfB/jVCkUNZ+6EmreX87Agu2Ytogu1Se4=;
        b=uzzx+eAOolFFCBG1Rwq1Fi8Qo6XhIHxrwRDoxXCmGTnYa25RSMzJ1MnKysCCSVhKIm
         2wMsgzeePfVOVmdAISz5TfEUnKMnKY7PZI4kDzicLFfIHtn+k4J0TQwh/jwI32LKwNsj
         hfRHyOf8xDD0RnGvS8dA9eo8WZlYgllwOwqze46zjA1yzlvB1+9TMS0+jvvYT8Ln8fVU
         t3AozP7nFrWk3k6qYxGWvRVoqZR/FYBKpuz+awBkVklambRNPEfZ79atts2A/wElZekt
         abZJ/QIVv3N08/Fn6HLJQ8MvQECxc/UdauK1rYQtDl4dvfjkgUHAME83HydJlQPRp3+4
         E9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWnk4oYeQllliMAFDi3RwGbpj9w2/7tUuBrle5EPWd7QSr8CM+q/ZkaNLEm2KRaSUJtF9ih/5qMAGCqCMDPocpE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdl6qi7C3DAplzkb85cneLFWmVElvi7YHpJq0bHsKDoLP/CopC
	iKJhmFmsYP5UPk/WwxpcOewE+utCSj5nVvam3jw1t0r2qZiUDivq3aDuLk1YduC4bCsBpDCz5Sp
	BuoSIPXu2DMtyU2lyC72mlPPa/eOtcb/l2irq
X-Gm-Gg: ASbGncvOG/sPVvf3mIybJ2AQfyh4aIPJS1Rh3guItMEgm9joBJxw3sYBncIuFT47fDa
	nDm0i1FRSVL7pDy2D7LHV4QW8uG7jmmhDYVuuKpjYxOs2glr2QngLObcg+dPcEXOg/xIUSxfEGQ
	==
X-Google-Smtp-Source: AGHT+IG2PZEPVN0jHc4P+ExauCoYGraNODE7PEkkOi1ZDm2UKmFVLgym3wxsSLiZQoE0o6kgrT5CxH4l66kQwIHnclg=
X-Received: by 2002:a05:6e02:1d91:b0:3cf:fdcd:8a4d with SMTP id
 e9e14a558f8ab-3d13f1a4319mr3380595ab.3.1738949983677; Fri, 07 Feb 2025
 09:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com> <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com> <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com> <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
 <58e08371-8d43-4f84-baaf-64b0af95c7cb@linux.intel.com> <CAP-5=fX+u_Un-WYKA35sc366kniuXFVfRDT+dzWd-axTG5PmpA@mail.gmail.com>
 <51732c12-b5d7-4b81-8ea5-79e87b87795d@linux.intel.com> <CAP-5=fWQj01O3WmGLoAf6O_uEeMHpOUqVWvHi3nW_kGj4VtZWg@mail.gmail.com>
 <145ce38d-67c5-47e5-9625-0ae9e9831fd9@linux.intel.com> <f0eb58c2-afba-4810-96d5-61f1c942ed57@linux.intel.com>
 <CAP-5=fW3eY70Vh_GuTVB=M2MFcpe-WqRy76cK++UMYT5OKMtLg@mail.gmail.com> <608077bc-4139-4a97-8dc4-7997177d95c4@linux.intel.com>
In-Reply-To: <608077bc-4139-4a97-8dc4-7997177d95c4@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Feb 2025 09:39:32 -0800
X-Gm-Features: AWEUYZk3WYTIZU97X64nIAVTgKop2yNKcEJMcno_p4UD4K2cx_w64MI2estpCs0
Message-ID: <CAP-5=fWRcA0OmJLxGTo3smi7QFzmTWs=U11WUZ4g1-rW9HLoyw@mail.gmail.com>
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids events/metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 11:53=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
[snip]
> No, it's the perf tool which inject the "slots" event in parse_ids().
>
> In parse_groups(), the tool_events[] is constructed here.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/metricgroup.c#n1557
>
> In the find_tool_events(), the tool_pmu__event_to_str() is used to
> compare the tool_events. It only check the event name, no PMU or arch.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/metricgroup.c#n1389
>
> So the tool_events[TOOL_PMU__EVENT_SLOTS] is set to true, because the
> p-core Topdown metrics has "slots" event.
>
> The tool_events is shared. So when parsing the e-core metrics, the
> "slots" is automatically added.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/metricgroup.c#n1476
>
> I think we may need a similar fix in the tool_pmu__event_to_str() to
> skip the "slots" for x86.

Thanks! Just thinking out loud, I think the reason we'd starting to
see this problem on hybrid and not on seen it on non-hybrid ICL and
later models (where I run the code every day) is that the
parse_events__sort_events_and_fix_groups shouldn't fix the topdown
grouping for the atom case. Fwiw, if I had a test machine ;-)

Ian
