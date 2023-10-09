Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D078827
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGYZ3ePn"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2409C;
	Mon,  9 Oct 2023 03:29:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so39728985e9.2;
        Mon, 09 Oct 2023 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696847352; x=1697452152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ip0/+mPmQJmFs7c3sMuooDCOD4Rw5IBThWyaWKWCy/I=;
        b=mGYZ3ePncwmAvckq2/4Se/5/WmLLLTOvD9y2jjRinmpA3wFepkF/j34Emg2v3xMGIn
         QTWix+cX+jEufuaQ2td2H6lXwlS07IPCKThhpxNc2f7n27IKW2gnjuv7s2d3uqCWWgTE
         0yDJhxauGwCd/8SHk40gwxxnEdfj1UwP46kI4Tq6AkvD0xb8kGSGWPagFyFK2hMr72QA
         jdwKFcMjAtM6q2a9U1eBKPWQCrHIwoYYeNM38fALOmE1rWqNbdIQNKI0c0HEulzPW0UW
         MiAph4RgYoyoEpU+cFFWwC7VLvGCpmo5l/fhT9JEg63KOyiNOBdIFKaDpuUsLB26jt8B
         4ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847352; x=1697452152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip0/+mPmQJmFs7c3sMuooDCOD4Rw5IBThWyaWKWCy/I=;
        b=EPnqXNwQ8wKiHYUCIIkH+shUgKLfUQx0vPDt9ca8jq+rndyrddsjpydiWurQmLSs5E
         NSl/AVyDCZjP8iRrXLcYtLWZZInm8dZbhQ2eJ72YWtTtfEUA2OeQ0kB2BL4JBXEBCI2z
         6m2cGkjdVgqhI+XnUechEMkucoXV07CyuZHdbSBOLxPfMY+Ymyd8kbAHTGJ3TYms0Oza
         /b+nBJDhzEZLn3FzI8xSuq5LafOQaB2nOORYUvNsxzfN1F9UOEcQEq3pnFtQDNN4CiJt
         PH7YDQjRrbQqJCAajviMD6TNoTS6R+oSsaIu4+QosG2BhyRB8PRfcq8+8yCL65WsRIVF
         Erkw==
X-Gm-Message-State: AOJu0YziU50ey2p76PKwGNX5bKIGVAhfFE0xxBgFpFxoZmGhVVz2UVIr
	9Hl0P7kBmYoILVxgL7WeFDg=
X-Google-Smtp-Source: AGHT+IGscfbKDuidio7TyUoys+MX9f4OTzBIlcEMU7DNivZtSiWk7bDCHnH3VXJjUuQwu2cw0TZRXw==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr13214510wmi.20.1696847351740;
        Mon, 09 Oct 2023 03:29:11 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b00405c33a9a12sm5236995wmi.0.2023.10.09.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:29:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 9 Oct 2023 12:29:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Lucy Mielke <lucymielke@icloud.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/pt: Cleanup kernel-doc comments
Message-ID: <ZSPV9AnhBk9Z/nfm@gmail.com>
References: <ZSOjQW3e2nJR4bAo@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSOjQW3e2nJR4bAo@fedora.fritz.box>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


* Lucy Mielke <lucymielke@icloud.com> wrote:

> Some parameters or return codes were either wrong or missing, so I
> cleaned it up to the best of my knowledge.
> 
> If anything I did was wrong, please let me know!

Your updates look correct to me too, thanks!

Applied to tip:perf/core, for a v6.7 merge. I changed the title, because 
these are not 'cleanups', but kernel-doc fixes for documentation annotation 
bugs that generate incorrect/misleading documentation.

Thanks,

	Ingo
