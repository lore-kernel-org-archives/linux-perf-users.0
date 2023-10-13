Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D294D51F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erGPeaKd"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0676CF
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 01:12:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3247cefa13aso1655984f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697184730; x=1697789530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGC52X+6EfdOM44b7esjFLrzvMzDKL2p4mgyAiVtcQk=;
        b=erGPeaKd63nm7hBvQllthRPPjZtjjs5Q8i/uQX8KVRUBp8ShKblK6Ie9HkYbfDL2Zj
         3eunWTOMPs1Uy71MgzpYm5qbwxz2F4Fn6IiGZvFNjSPdNqKDS75f8RoAiQ0mqiK9Xvko
         9SqWgT9dgzm7x+Gd2qU+v0j43QccVHZXmV536A9rnb9q8tlcEbmry9SKlbTeB4CJhxNB
         nIeilfgWnhAq8W+g5fz7rjuCS5rfhk4nMHL6NhZSTDBKgtYb6o1t3E4iw/lwg77+N7EN
         aA2BqX/gmkhLtETUT2+8KQTHdvGO/S9TPKe9QnvuypxewJ1uk0YBDLKk2bHu0AgBMW4V
         1DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184730; x=1697789530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGC52X+6EfdOM44b7esjFLrzvMzDKL2p4mgyAiVtcQk=;
        b=dAhIaD6KJAzeerTxqFKkyLvCER+gzB5YjnJTKPsRERTqbnCfpsqOPZEL92N4DWEOKj
         AKGCkVJyPpX+bdFfjk5cW3rQ1o44XMn7jwvYmmhWUkbYDEA5KSc3IdWKWGbSzoExVFmV
         5pO/9knGydzh5/hhgthNx4AKKtFNFfTNYDVER/rwixCYECvKhrfLV6IOwbXFhYfTITHV
         4z78jq9MUsCdy30OchDp3St+CnhThzRd6jlaAVS1xNuGbr30sRnvpfxlF3yrppjpRfac
         QdGMKjP61brUjNTOKTFqCRYySlC6A9MxSszC8yL19nLqRbQd7/mN8JDSCWAu7yw3AZjy
         AYMg==
X-Gm-Message-State: AOJu0YwfAFp0kP85pUfyhZ49hn2AQopkCULdXBLqiPVIEBR0JgKMwSxJ
	E6tH73+gFqWqrpdm87mIuc3QHQ==
X-Google-Smtp-Source: AGHT+IGXwzt6GufVlnOjsPlfsRIPzlaGtVvngq610MlsMUP7gghxkfnbbfFsixU3uwFuXhpwNvI7nA==
X-Received: by 2002:a5d:58ca:0:b0:31f:f65f:74ac with SMTP id o10-20020a5d58ca000000b0031ff65f74acmr21004242wrf.70.1697184730218;
        Fri, 13 Oct 2023 01:12:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b0032d2489a399sm2745645wro.49.2023.10.13.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:12:09 -0700 (PDT)
Date: Fri, 13 Oct 2023 11:12:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSjyJuqk3z0RyKP2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 09:30:46AM +0200, Ingo Molnar wrote:
> Ugh, why on Earth didn't GCC warn about this? The bad pattern is pretty 
> simple & obvious once pointed out ... compilers should have no trouble 
> realizing that 'ret' is returned uninitialized in some of these control 
> paths. Yet not a peep from the compiler ...

We disabled that warning years ago (5?) because GCC had too many false
positives.

regards,
dan carpenter

