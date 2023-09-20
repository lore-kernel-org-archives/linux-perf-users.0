Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5941225
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 20:15:41 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A03C9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 13:15:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ef80a503fso10086285a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695240939; x=1695845739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjiggUyQYaXdrX5h9h6CEmaZNsBN7wNveaVEjl3faww=;
        b=gzcneh+E/b39WZFZXupKfrJrFkgyKJK9LLcVsVadvicyjNcx3Oqe/r5Ae8yqn1Sqf6
         aUlogDFXfVuZkuF13TiSBw9uZGqlk69veUO4L6dG75tVnFfk7zpzik86CadtK7IbzHO5
         LWUP49N5s65Z48Fyi6pNFIOpU0lXEfIaWhOxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240939; x=1695845739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjiggUyQYaXdrX5h9h6CEmaZNsBN7wNveaVEjl3faww=;
        b=na8tp1sWvce8JPzYLF0VRp+8iR1J53l36g6gD7edHBvw871KcP/EROPVgsou360rvF
         9cF/meyPS1Pmc0dZcGj0bc01GO6lVz3I51lNne2+ILru3j8tCyq0zASXKU1QBOjdRB/R
         MXYzCiNtfg5VSC0tONJFwIPUr61BLwPIgqjnMwabH6hFho3p2lgmm1CPDPZksnMzD80K
         L3pvyVZlIZFpPFkMd6wPszDGp+z8J2DqZSX2T1eKrS0hQnC+ae1sk2M13HcubBlnLPNr
         HlfOEXQJD2aYPQNJ9H1d5lPHbthXojDzFotZA901msEvBl6dcbH7P/9nNvRzPMVWHCVQ
         ucqw==
X-Gm-Message-State: AOJu0YwroX6x+rPftQu0Xcvu9BV7ttV74XiOgVUBeGna17t+3gyUXwKm
	iD2gnuYzTUUWhwVXoFID9eiGlw==
X-Google-Smtp-Source: AGHT+IGzk01VxcNRtiMCm3IRpOiOofgFrIbB2ochwvXCEJnvd8LLC832yOxk2yPa78lhoBtatxrQnA==
X-Received: by 2002:a05:620a:2943:b0:772:6419:89ab with SMTP id n3-20020a05620a294300b00772641989abmr4647613qkp.55.1695240938672;
        Wed, 20 Sep 2023 13:15:38 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id t2-20020a05620a034200b0076ce061f44dsm5369qkm.25.2023.09.20.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:15:38 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:15:29 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: dwarves@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-rtc@vger.kernel.org, linux-trace-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure
Message-ID: <20230920-ligament-cortex-6344a0@meerkat>
References: <20230920-uncouple-grime-729f33@meerkat>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-uncouple-grime-729f33@meerkat>
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 03:52:05PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief 20-minute delay with archives on lore.kernel.org. I will
> follow up once the archive migration has been completed.

This work is now completed. I will monitor the performance to make
sure that the new infrastructure is still successfully coping with the
email traffic.

If you notice any problems, please report them to helpdesk at kernel.org.

-K
