Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACF39D6E2
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563643; cv=pass; b=iwrTPmeJ0fVcrUaoYKoAwZBJrgutOyuWWRgAAtQJKaM6DkGgBcrLzoZldg8xBy7BAeyCI2ANNto2+injrCHHCJj+vC2EZWpk/SqLxOM85QdJy/gR+EO2OJP8WbKJpqgMkW15AIa2N9t+UYvGqs/n5f6os5OMp+rYL3Fn2X74aT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563643; c=relaxed/simple;
	bh=BGQkCLP88N/BbtvRuzQ00Wcutq6wqdxxpsiTgm66HZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4LuWkIdSj2Yc9fy36Ka7r//EKQEVTZ3RLhzPX5RRzWrF2QL9LSlkbEu1f+pU9utL20oWVomk1YmgCiVJ3G3KBV2N8GpCk9srN44OmByh6xEhdsCbSmu47jgs167DnacUckAqpOvxqX7cDOTpOgt305/mshJL1f1JcLTMukYtWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7ClgWAj; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7ClgWAj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae523d54d2so101135ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 10:47:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563642; cv=none;
        d=google.com; s=arc-20240605;
        b=lbW4P/8gKQCxZA2GxfBGvnxXGDfy2p5JbzXQQrmF+6+Hf9fCkylTtjhMkHvcVdjc3R
         wAQuAulV/jRv0zuqFXDlQ4Itggy719XCrJCiAW0m6WchCg5kdRYg8+lFZ0itqbYHdmjg
         q0qc8D0uuLAID4cfehpakzqLkbMxc0vN28luf9SLgXZnjemqIx7/eyHhR1Rug09JPd1p
         QH/Gz5ScFkoksV2iTUvBYaExSpepoN1PFsxArNZW+XaZVEDZzmGVT4vaUJQB7IQxuttW
         QbfejjEGwWKPU7tgDSLtsLo2R3Iov4Lac+AfGatdBJTfyj6lATlWeoV8YIWzDaFwqu1x
         ugMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hjsRnqUMw8HW6VrxnRyUbl2QG/8XkPbK/Tr5FVuMQFw=;
        fh=+nV8U1LAgvobXBrGhSzUCXv7hXneTydiC0Xs0u1SCoA=;
        b=FzH7wzDWF7yH1WRc5zIT+UtP+DhlU7pelw7dK4YN1sTcSMeUwgLPehbsiC1TR18Mkw
         we+CpRTZ+ksniZMI2CX9eX6ZJCQCsfT3MiT6a4+rFedZLSsFp4iKE7xWLd/Bgs4mohNu
         xZBj4Dx8YhPQiDL1GmUfZ+wUFglU0rR7T5fd1jtNdwAxM1VZElGVr3gDaY/mb0X81eA5
         zomDwawcxSsxBdNLCO/5sj4qOCw4gi1XHZDwPj36OFRMY4Z9P7f2nPjfG7i6ZTyK+wyM
         72PZY5MRcWyD9SWhdSJ8vIwYLpqjau8V/eRhJCAzNbK43h8EGjj1VHKcNEJNGoSTt3NQ
         ZNXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772563642; x=1773168442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjsRnqUMw8HW6VrxnRyUbl2QG/8XkPbK/Tr5FVuMQFw=;
        b=d7ClgWAjJ2FaJUCD+e0Un/In3tmpwZShYgmsi+Ol0xewcHZ0gDxD+I2LLqWXd8Ijqd
         w6cFro1o9NOF9DXavMXh1kmdZ31y/MbTqEilMl8CZUP8VbiN0n4YCWduRQB9uyOGlk56
         AuudnzeZJPJh5PZS+9dW42a5BqXHe8CkdVXxg4v4kYQBoR3RhJh6w5FKUN3SyQVNtSNj
         K32CA0HWViQulTn41uenWUyLbSmvW2onOTzKtOgya342Q8yZyi9sE4V0+I/Gk/mzF+pZ
         /Qrch8MsBBlGxdhEsffCNkL/4dyntgHBnQaWjOXrsYC3k3vgcRFRnC0BSWVHLTrhMx7R
         OeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563642; x=1773168442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjsRnqUMw8HW6VrxnRyUbl2QG/8XkPbK/Tr5FVuMQFw=;
        b=SNrI7KBCmLdonEi1ljZsvgMHNxMVUiaK9qJajmWUpXmaK7hrS3WMuu8jyqEnaIogMf
         KD/R1jspWrIzPT4rF6528wKZ9m8bDggoMXMLcWdEU0lMoXX3w6folYbsGKcnDdzy/RhU
         YNe7iLXG/2cMQFR0E5z34U14QFbyCRdlXi7iutuTkm4r0nnHFQ5XRDk9iN6ouD8cpdSq
         jP9Am+sZFLh8lAwhONlivM2M1se9vxZV63jp2XvIYdE8PlgjczdW+By35Kyz/iRbwKjn
         tKIz7UFARoTGhYmP9nAByM+kXJ/K+/XmScM0Dm9mAX0JmH49pxfjjgxsMSKYgCQn4iZa
         EVQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXxRW1iRQXmVZwge1Baj/QqySKJS0HsnJlU1I/+zY4It+t3iESDIpy2PX/rm+V/T8o/KuS8Qgi0ffKiC8rUTx+@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzrQUQrvbsurT9Pc47Po+hMLBENVWXCwS+/h5PYEt+LiXZAOa
	rsyiAI/Bo5CdR8AYq2/qbovVI8lmy1aAjSUfsf5SDerJeUwWPsnxF8oug+k/iJ4eycCETc968CU
	XY6Ik3tc8T8kaGiXaAOzl8TKLSf+//hv/zlYgxhV5
X-Gm-Gg: ATEYQzwiVcmSaPyJHKQqFkQGYnIIkpdqWiaseY3ZlvqCsub0Jq/A2nPoQAZWRDWMPjG
	hvK6vYtqrkDOtxgcIQ8EHD5usuTMy1EYpv0Gex7H3E9UJMdfYeVrl8myjQz0epN9mMg0XZopINh
	JbjP5L7MSQIscgDhf+1II2oQJm1f+obZWg5kApbeakowsSxJBnQ5AC+eCeQ3gL0uNnGXmGbCASP
	QAuaYpUoTI1hkguMj4U5hXmTnYmOEJcg2b3jDUdpZaL6aXjawPoKC2fw8WoUDhwOoAu9DDwxB+X
	WdhSmBdbh735h83DulRZ5q8bl+L+e7W69+ZAAQ==
X-Received: by 2002:a17:903:2d1:b0:2aa:d5fd:5d76 with SMTP id
 d9443c01a7336-2ae3b3868d1mr7046295ad.1.1772563641110; Tue, 03 Mar 2026
 10:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119175833.340369-1-swapnil.sapkal@amd.com> <20260119175833.340369-8-swapnil.sapkal@amd.com>
In-Reply-To: <20260119175833.340369-8-swapnil.sapkal@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 10:47:09 -0800
X-Gm-Features: AaiRm522y9NG3oJC2cMwawrOPw_mQbXruKvtpI7mC4Bt95kBD5VGtw0vnzk1Tq4
Message-ID: <CAP-5=fXNtVXEjDD-euueztjO7vj+6LQ2CHgHfxVoHuRF2Nb0Xw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, james.clark@arm.com, ravi.bangoria@amd.com, 
	yu.c.chen@intel.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com, 
	void@manifault.com, tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com, 
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com, blakejones@google.com, 
	ashelat@redhat.com, leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com, 
	yujie.liu@intel.com, graham.woodward@arm.com, ben.gainey@arm.com, 
	vineethr@linux.ibm.com, tim.c.chen@linux.intel.com, linux@treblig.org, 
	santosh.shukla@amd.com, sandipan.das@amd.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:02=E2=80=AFAM Swapnil Sapkal <swapnil.sapkal@amd=
.com> wrote:
[ snip ]
> +       /* wait for signal */
> +       pause();

I'm seeing the perf sched stats test hang here, requiring me to kill
the perf process started by the test. It is unclear what signal is
being waited upon, but is there a race condition where the signal
could have occurred before the pause? Should the pause at least be
conditional on that happening? Given that a race condition would exist
even with a test, would it be better to use a condition variable?

Thanks,
Ian
