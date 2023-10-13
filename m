Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F1200B7
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWmCD4NQ"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B94228
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 09:13:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3e0f8872so2984108276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697213605; x=1697818405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xx0BMu30zSxzvDEomgzg9E7JT9rYro1tljom2/GGKE=;
        b=rWmCD4NQ8jNkQakOaTPmXWmr1an3sT6PvgjoRNlGOKSlDaFVpE3WtlV92kXTlLY5Ep
         gy4+BOqGjCu1k7TzuX5Y316BzsVOpBmAGQKLEqm56BWsH4juZkohVp6ZQ8qeUonRyfgG
         +RffzadLU+0kKF+52HDrSaeTs3Gf7qBsiO8nuLUcVCDs/89md313fiGqMTdDrdzrPmug
         cbzLPfcqweGMtpVo4F8vXxawYxSGRzxvs6vlzGZUo7FpPYvwfqLKNtFwhKbPD1acibQK
         VE8N43M0kQ6CF2NYLQg4EkyJSPQhQkXqhjynQ+i6qKK0BdVEszz44GWafU0IBNKgiu9a
         yatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213605; x=1697818405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xx0BMu30zSxzvDEomgzg9E7JT9rYro1tljom2/GGKE=;
        b=A+F5iwE/qvOrA8rvAKD5RnW7CCK3gpTvakH4IHLuLLxQ6TfzhaX3Jsxb8xF5RJgDJ5
         EbNJy0lT08K+8/Fc9zDfUtsGTfMMJAjgJAJDJYCHFWWlKWtaaBS8Fo5qDCyTCsRuiq6n
         JCRtc/lqKCl5w+EO/Vn3rWSqmJTQiiQWLy0GDiP93klgWFpunpjwNFcWRjA6IvIjBmOa
         yFgiU6DwPIrZMasSKCx6uxmDBTrZBYZz9h+6+Gu2S9YAwSSADc2Ql1zl9/GF7faroYjQ
         u+chZcPeP1l6DYArjC1wEskPk1a/8vo3DGrfGqNRIj+AGvKEq8F9jyb3Vnw4mkz2BGAX
         5kXA==
X-Gm-Message-State: AOJu0Yx4AmsoBiFJ9b64OcS7V6/gZMaIgg58ptQbvbgpTeSPSlmc/UDQ
	JDFplQHSDf/Ur8z8otED5xzfc4GR+hQ=
X-Google-Smtp-Source: AGHT+IE10ZBYKMQNsvc4otdqbSm0jYPRU/RLCtR3agfzWnBXi4zl5QG1flqcubxcBd+LqSyFJIHYTvcnNks=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:5c9:0:b0:d8b:737f:8240 with SMTP id
 w9-20020a5b05c9000000b00d8b737f8240mr566788ybp.0.1697213605131; Fri, 13 Oct
 2023 09:13:25 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:13:23 -0700
In-Reply-To: <ZSfJ6c5fo5enjvv+@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZSGpl_hT23B6ix0M@mainframe> <20231007203411.GA8085@noisy.programming.kicks-ass.net>
 <ZSQqfr96SfZM_OEk@google.com> <ZSfJ6c5fo5enjvv+@fedora.fritz.box>
Message-ID: <ZSlsowuVqQA3ecUb@google.com>
Subject: Re: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
From: Sean Christopherson <seanjc@google.com>
To: Lucy Mielke <lucymielke@icloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023, Lucy Mielke wrote:
> Am Mon, Oct 09, 2023 at 09:29:50AM -0700 schrieb Sean Christopherson:
> > 
> > rdmsr() writes to "high", but nothing ever reads from high.  FWIW, I would _love_
> > for rdmsrl() to have return semantics, e.g. to be able to do:
> > 
> > 	low  = (u32)rdmsrl(MSR_IA32_MISC_ENABLE);
> > 
> > or even
> > 
> > 	if (!(rdmsrl(MSR_IA32_MISC_ENABLE) & BIT(7)))
> 
> I have taken a look and it seems to me like this macro is called quite a lot
> for different things thoughout the kernel tree, including drivers. If
> one were to change it to have return semantics instead of the way it
> currently works, you'd have to change around 300 occurences, right?

Yep, which is the only reason I haven't force the issue.
