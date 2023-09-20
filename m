Return-Path: <linux-perf-users+bounces-1-linux-perf-users=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0009CC04FF7
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 19:52:32 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBE1C2084C
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9183C450C6;
	Wed, 20 Sep 2023 19:52:18 +0000 (UTC)
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B43FB0B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 19:52:16 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C1D6
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 12:52:15 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c0442a359so2836847b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695239534; x=1695844334; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=IBfe9QuYzIjLJoMieQ9UClN+pIjHMly/FiZINK7vZf8eX2tHxCJ/6Rb2NF4SAKW+hU
         FpJ8BvtJWozoQfGKaFS2QpgBqZLNwutXOUeKjWt4xr2vzw1WXDbdzqEkOi9oFob2/miU
         UjpHeeGdsXA+BfvdR9BaHw248Y7AGuZcMebM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239534; x=1695844334;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=KdPzsRP/cgKZsiiu4Ts6cTm82C1kP+4HjQxwL77HqGS3L8TuehfkR8ND7x/j3oar4e
         h7/aod9+lDXR6ihd3WfEufaMorQbtEDqCK3iSJxJbatRr4HnoJ/fHnQUHSJ3sPOoy41o
         g7+ERJOQehxiDRCrtIaR8eXe2/Io3TCHOED4PrHy211JDPj303hMbLlFYgcvMM2UcrFd
         QxJx8Bk7bptqxsp5ab1dlgUsENoY7aUg1Ux+A70zcfEe+oSNtqgmwYD5uxi5QCu/fBeR
         NU3jb1PczdDh2UOceeE5XbpNDJ22NALeWqcPfVCufxgO1ineBI6bm5rof0+PjAK3y/y+
         Ulfw==
X-Gm-Message-State: AOJu0Yzn9vai18YkxxmJnalcYK77DD05B7LYBUfWpJ9L8WQEXqjSgij8
	R3Bs2NAp4vH9m74D6ymFMvvV2bYOtknsrkuqvPg=
X-Google-Smtp-Source: AGHT+IE34WLE4Cfpn3/mrrUYZ+NVqbx/9khGu7tOlXbwDv4JWUwVQmIsGV3ZOglYnX/uY5dff3oc1Q==
X-Received: by 2002:a81:a087:0:b0:561:c5d4:ee31 with SMTP id x129-20020a81a087000000b00561c5d4ee31mr3955439ywg.38.1695239534737;
        Wed, 20 Sep 2023 12:52:14 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b0076ce061f44dsm5062450qkm.25.2023.09.20.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:52:14 -0700 (PDT)
Date: Wed, 20 Sep 2023 15:52:05 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: dwarves@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-rtc@vger.kernel.org, linux-trace-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: This list is being migrated to new infrastructure
Message-ID: <20230920-uncouple-grime-729f33@meerkat>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief 20-minute delay with archives on lore.kernel.org. I will
follow up once the archive migration has been completed.

Best regards,
Konstantin

