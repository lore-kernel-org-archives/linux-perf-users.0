Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F236B;
	Mon,  8 Sep 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310540; cv=none; b=o2aYJWDElsBQ7HbISkxgV88RZF31kCF8PQM8cpsk/B0pPBletVBI3M9uTS4CHIor8ov26aHdYnLm9DmFAHVL7KYpM21EsKfnI9OHl1zx69N+7zFWOdd7hzPJwpvaeuzq+ven1OlIaBW1npo/mFJ/ITzr7+IS5tVLU+nPD/KCQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310540; c=relaxed/simple;
	bh=COeoU0ztHhCgdeys2glEUJvCtfcCVtu34Nt5vKpb1Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp7zAxZoR+IJnVGkyUPM81B6S7el7GaUjCFyekdhm2mhCK3IRQY/pXvv46bTXBq/BlfRBBpK9hSCrV4GJrmyC10B8Hj0XUcis4ej71nSNzEpbk+W8WE4pDtQHirfFkMZKghmeYGVNmJqNC7wk+iE4lrdpFEKMCcZ3q8E8MQnFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knnGbkFN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knnGbkFN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772481b2329so4174776b3a.2;
        Sun, 07 Sep 2025 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757310538; x=1757915338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoqFcoq4GIfiHOtzMW/QQ9khjq4YgpmVFRd8SsW0DUQ=;
        b=knnGbkFNyiIEvR0R/paGPk9J1sjh7zJb7sW9aftIDUG2YXYp8002NZqdiDi8wVxUCV
         0sfu9+4+5Io3XEcFfzTMqRdmz95oWDm0BWP98DBPwPH/lIBxwD5hoBjx66CWH4By1Z75
         Es26zj4OK8K5YYRiEgYKtT6HJ6OrOShb6s+Nq5QcGty9DCadYds6GEhCO9UA4Shh8jCb
         H82xwzjFXpqwM7UOJ8rrxtIT44tu/Zg+gviQQFJBtEx5Y46rGFUVp560SoiXUFw0xr2N
         4+61WBIvT4BWXnNhlizPWDpiEDd1STgEpS66sfOURlwG1Bn3GNk+j2sVsLg8nDZJtQSK
         lsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757310538; x=1757915338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoqFcoq4GIfiHOtzMW/QQ9khjq4YgpmVFRd8SsW0DUQ=;
        b=QVzMTtEz0KpShJ7VwVDGRCvSwWEby/qjaQzlwdLMbj8C3tkrmaI7oLp9hs6ulmZSqz
         T8wQdHtoiIniEvDUOjYEM4yTZqijKrYE5vGqtIbOC5UfzOauWalmhJihWZVZ/zRFuBQm
         ziuDrwwW0TouAIVVL6OYjYVWTrViPx5qO1JLE611oCfqgh5NkGRFvnFuKaGqUtY1mX5F
         UDpLH3dYySPO3nILB2dzIQQJXUT/pJkY+n5dJRBuwR5mejcIi65iDhsgQ+U1Vyrwpm+c
         fAOLduCcmaTGjwCCDQjF98Jf5NVQ9ELT+9iOiLSeaeq9983CjKzRmgEhFHuIiCjfnYio
         24uA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vbyD1mnxcaJWt92Jv2V42dpscNdVQHa91FpYf10D6OiBishzpOUTwN1tWvPvHD+MGqlftH4fsKQ2I4PCGgHWow==@vger.kernel.org, AJvYcCVHP+O9HKPJLdOF4Ra/HkzvVxETvqc6qGmGsH1Cf3ep4ZkeKnn+bpfCMWIy8FxLXlVSTF1MjFzcSRuba4d9QHsDcnAT@vger.kernel.org, AJvYcCWlSNDnLkVBOvW6pEQNN0rUj5Ba+AuqERCGkuKP4p8O56rmxvcA/p4BNoetQbR8dKSeHgW19Qh/0uW85Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xebggstwu5NMH6kpFsTMLGmISC7ZK2UaVR6/tNiB2P7fPLux
	PQEUDpzFX9qkHYlXqhtBqO1ML0//TbICTfKiuxZ8Y6ITU5itH1kQzGs5
X-Gm-Gg: ASbGncvlMZD051b2tzoqhDv4YzyYPDAxR8SfXyqbtH0BN1CZ2u5ddkbKPZf69qrYcYl
	YlyerMj/xbBX2VqdW6DEZ18irrdtc7tZALB8+9QhVwJy2jxvaSY3Aw/GpB0424bl3/eI1IJm0/N
	2S438pxskZtqV1G2yNUKcpsQpm0pscAOtwigDfhhktlfv62ApB6zu3Llt84liPsr4ZF2oHTS4K8
	StkLYfa9XS1Cuo2H9DjNn4VZitejNKjc8/afRvwM4bB3PXEzR20KcXRby3PxXDV8rY6mllE9dY5
	j6Y7aBBnI76q7np2Np0fjY55ztEMfXIrSnG21h1aMO4CdGBb0lpHgJ5oK4xa6/ov76mwMehyVMD
	jvnAQhFSuYh537rIMZseEqRga+u+7GjulNgOknA==
X-Google-Smtp-Source: AGHT+IG1bacu1jG5J6SpRnQGjBP/OMKnF08uWVko2woVDz6D1n5Xfqa8XGMBxoTAk8FeDTYRaTzoLQ==
X-Received: by 2002:a05:6a00:1307:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-7742df2ee4cmr8310202b3a.30.1757310538216;
        Sun, 07 Sep 2025 22:48:58 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77285bb2614sm13018142b3a.58.2025.09.07.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:48:57 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:48:51 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] mm/ksw: add build system support
Message-ID: <aL5uQw2SQmHmCw-l@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-2-wangjinchao600@gmail.com>
 <aLlD2CDengxSl4fS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlD2CDengxSl4fS@kernel.org>

On Thu, Sep 04, 2025 at 10:46:32AM +0300, Mike Rapoport wrote:
> On Thu, Sep 04, 2025 at 08:20:58AM +0800, Jinchao Wang wrote:
> > Add Kconfig and Makefile infrastructure for KStackWatch, a real-time tool
> > for debugging kernel stack corruption.
> 
> ...
> 
> > +static int __init kstackwatch_init(void)
> > +{
> > +	pr_info("KSW: module loaded\n");
> > +	pr_info("KSW: usage:\n");
> > +	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
> 
> It feels like this belongs to Documentation/ rather than the kernel log.
Thanks for the feedback, I will add a document to replace these logs.
> 
> > +	return 0;
> > +}
> > +
> 
> -- 
> Sincerely yours,
> Mike.
