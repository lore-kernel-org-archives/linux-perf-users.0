Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77A21B91D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182412; cv=none; b=iGhNlBMAQCHGvAB484Wg3tpHbPR+gPnTuedVBxja37Muk2Qf3S3Tc/qjmJjrjUo4AGjcqX3IJk/pOoOf2WOe4WfmsmIoIUfLe6+AzxZ6na+ZAVTbRFL7+/IqCDj9WTN5pMU2ZjeHWYiAS5C2QW5IBUCePIfYQEklRxHJhv87LmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182412; c=relaxed/simple;
	bh=nEbS/u2RQQcYbrbJKPWfQ5L+q5LiXJAFL1FpwJCPoC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hlSQDz9Vt0oK/eFFr4gplTtItzjwvkNOCchkw0E/JVvyuKO1lAGdNYosjhxGt7AhteA+GYzPABHwIO8/T4JLjoMupA+onaembZFCbnxoQIR0KZlC2BYxgy6zaimJSHN36aJTBcsH11TkTGZg5wf50cP0IWmzslmKjH+lqYwVW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hktBUjhP; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hktBUjhP"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-383153e06d6so26624811fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 17:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768182410; x=1768787210; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEbS/u2RQQcYbrbJKPWfQ5L+q5LiXJAFL1FpwJCPoC8=;
        b=hktBUjhPDIgpzEg+6cCYtgTHII7Jad1FaryBv1kk3RZ+vYZhaWaM5cI7cpfSHvaeQt
         aU7/FIwKFdzm33gQ1A4g8eSsDhzot1ooxVKWZFD1ZqLRhFURDULQc4U8Xeo9JNZCeS+U
         Q2cmr3LOME5x1+bHKHjQMTcvw88iesWh/vm6hO1NX2ei5QEJtBcXCLCncYpi2YAQWe7G
         /By3b4oAfUh6cmlZ5uKlUlh15568Cc02T4J5FOHZ9ygFvXL8A6d309h3lLaiyCVSSslT
         5m3vdwdmUHQy7PN660IeOYdDiCs1s6tNHruFeG38jhyTX5Q4tfPhpoC8ywgOWsiKxrEE
         ZCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768182410; x=1768787210;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEbS/u2RQQcYbrbJKPWfQ5L+q5LiXJAFL1FpwJCPoC8=;
        b=rz+WjUeObO22lnRDD5N8PkNCVOoYr+9HR7zlmfl5Nmn9QUpmshj7smyxUouumiwTAs
         2soskWO6+j3G59vMvRpGbHKmgsqfpzQlTT1OV9Ld9bkAf7UGkaycINDVugi7ACZ00ApE
         La+XWZ1vZ1DfGNWtlTV541WPdyqVL4opBrdFyNmME1wcXsZnxM2pRPHQNOBsba0sjPfZ
         mutFlzEB8rBF26yJ0ueAtpDzzzFD/acsJP0+1EvOoAJR4GUYhTTn1DCLkeJ0nYQ1PEwV
         LVWfAv6SfP0TH8usLo1HI0mWHCGyCgSAVAf1NHDFmvKA9NyPss3J2N0Ilsbb4noKttID
         TAaA==
X-Forwarded-Encrypted: i=1; AJvYcCWLHnamOgQhS52duajHYGg7iuwupdUduSn8yJZDUGRmX7xK1DSqFLzyyzPIeHfxMhOQjeE/0aDS5OWt30y9QuWK@vger.kernel.org
X-Gm-Message-State: AOJu0YxUF2rTvf+8EmeU38BmWWy/jXOa7zw7jGTDL2HL9St65IlZB8xv
	tOxiwZ/0eXdhd6RUMJuJMq891SwghTrFh/ebNy2BGWkdU1zG6FkghzjF+Q6NPQ0EcgFd4+xLgSd
	17MJNPrKMlXVfzCOREFG8t3f5SjA5e1s=
X-Gm-Gg: AY/fxX4lu6B++f4kdJz+RYPufOfA7/ilNkaM/0+zZ/5oZTb59FOxXnHIgpKleDFPQy0
	8XUITHvlqSvd/tIab667Y74qcd6VcpmefthINzsApMVoH+zNUotVuMLW2VB/orSw0agglVa+ROg
	AslHxmg0aWbfj8TlPeCxlF+8e5H6aVTxL3a9kkj1pJ/kozj7xirU9eeNlcIDENbeQa6tgTdK+w3
	ltdzBL0VAPYHQMSqgR3vgWeAPp2UK/dO+WJjX/MItd5di502QJMHYw0kivmyjx7wc9tRvFWmxGY
	HpEw6Tk=
X-Google-Smtp-Source: AGHT+IFFpwzTXrZRWWTS4SqiF2TooCPfdND7LQbcPh92LwGsCcyKVlkAaUkkFBv7cb0PtOc7uKfEgzgNAyHXbkUFUVQ=
X-Received: by 2002:a05:651c:2103:b0:383:46e:4b50 with SMTP id
 38308e7fff4ca-383046e4dcamr54169621fa.40.1768182409357; Sun, 11 Jan 2026
 17:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223084337.3789-1-hupu.gm@gmail.com> <20251223084337.3789-3-hupu.gm@gmail.com>
In-Reply-To: <20251223084337.3789-3-hupu.gm@gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 12 Jan 2026 09:46:37 +0800
X-Gm-Features: AZwV_Qh31RHE-ZoDZTo_QRvvWB2SkShFywUC-YhkU2L6OpiFx26tkfkIuGOSbSI
Message-ID: <CADHxFxQkffVfxfjkX5+F5Dg4ewibB41aXSo6f5icVwD8fghjog@mail.gmail.com>
Subject: Re: [RFC 2/2] perf build: Prefer kernel source headers for BPF skeletons
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, hupu.gm@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Maintainers,

Sorry for the noise.

This patch was sent nearly three weeks ago, but I have not received
any feedback yet.
I am resending this email as a gentle reminder in case it was missed.

Thank you very much for your time and review.

Best regards,
hupu
