Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB93FB34
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2023 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcAe94TZ"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80F1B9;
	Tue, 14 Nov 2023 05:36:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c34e87b571so4676254b3a.3;
        Tue, 14 Nov 2023 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699969000; x=1700573800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgJwRlEMoHzpEQlLwG6IQKGKZ066IKihId2W0KLkg2o=;
        b=XcAe94TZJocshhlnsoVFUyT4oTN/uaXS9N1vfPoZDnXOZSM2V/7T+6XR7Ys1vNtcfJ
         d7ozcepHpHKWPoEKVUp2sFd8vSO0bE5fdoA4FsmpKRYWMSOodCgDYb2FrtOinKtVNa9P
         jPEB6og8KKzRDYp0GB509on1rSGsxLp9QNSNgvC1yJywqh/KueHybOmtroPNm9vV9S8N
         InKzFBLEe6W+O7tWdwxRIzUdGC6jWS2PejOSu+ora7w/7kT8c1SX19/unIksACJYAJ4v
         qfVtd4DFE9Mn9X5ovyGDkRWddRht2cpyP6czAOPmWWEmbNWzPj8T9kzFGgIvgpxME5Ro
         824g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969000; x=1700573800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgJwRlEMoHzpEQlLwG6IQKGKZ066IKihId2W0KLkg2o=;
        b=mPY+sOz4zC0xY57F2vyMhxaSuFC65zOVUC8xulxb9+kz3e012Dr9t9ps4s2qRYU51m
         zXbtwF7pliv07wnU6YDrZ+wnHS5b8ZfFZyKPnzO7eRqW6f6Rr7QPvLWpANObu9U4i0bR
         45n//T8I8sS3748RzyYNxXTs3xwLQtrwPDEYr6OrF6QyBOm5q3wYQ62T7IdupkEbKJOj
         HvnmF0jGNaJxVv+ELqWZHqsr+FTKjEcZSnm07jfLKnkAcTLaqrajJBwYshfIhNhzo5rP
         WbNnppAwEq+JYvhqP9bsJWXKZGWl5/Xud5XvYaVXKAccNtDCj3pMlF8suy63sy9AMN5A
         5RWQ==
X-Gm-Message-State: AOJu0Ywi4lirfFJHWbwXBh4VDe8XjPdsYW8r5Ze4p8AanzN0+L6rLOsg
	mjS8FGZ7hGkaOZF0cnp++dY=
X-Google-Smtp-Source: AGHT+IHwC9+iiP2XoMjsRObvZ8Sr1dpHUfScABioBmEanqShk/UZJR+IF+5VXhYhbcLmcwLerU8qVQ==
X-Received: by 2002:aa7:9a82:0:b0:6c6:af58:c9f2 with SMTP id x2-20020aa79a82000000b006c6af58c9f2mr6255960pfi.2.1699969000145;
        Tue, 14 Nov 2023 05:36:40 -0800 (PST)
Received: from [220.72.86.144] ([220.72.86.144])
        by smtp.gmail.com with ESMTPSA id fa19-20020a056a002d1300b0068fe7e07190sm1159601pfb.3.2023.11.14.05.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 05:36:39 -0800 (PST)
Message-ID: <04449bfd-7eee-4e66-86a8-4065be0b1127@gmail.com>
Date: Tue, 14 Nov 2023 22:36:35 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script python: Fail check on dynamic allocation.
Content-Language: ko
To: Adrian Hunter <adrian.hunter@intel.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Sean Christopherson <seanjc@google.com>, Li Dong <lidong@vivo.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com
References: <20231112071446.7811-1-p4ranlee@gmail.com>
 <5a909795-bd93-4c33-9de4-729f45182427@intel.com>
From: Paran Lee <p4ranlee@gmail.com>
In-Reply-To: <5a909795-bd93-4c33-9de4-729f45182427@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023-11-13 오후 4:44, Adrian Hunter wrote:

Thank you so much for the review Adrian!
My first patch were my inexperience came in.

> Please ensure patches compile before submitting.  Also run checkpatch
> and fix any errors, and consider fixing warnings and checks.  Have a look
> at checkpatch --strict also.

I'll check you mentioned and send the v2 patch.

BR,
Paran Lee
