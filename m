Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA26C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Nov 2022 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKUOId (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKUOIL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2022 09:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114FBC76AC
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669039438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gpRiqy0kwVgMdz1yBw1kbEJkrvHf1eUDUqKJWLzJ948=;
        b=aGGU/HAmc/IKuXO2EQEu4r+vCrqL+Vvf8zGgLStanp1pkvKqTS7IZfQ4YpO8b/xWZaIOe+
        v5QC8O18i/U+fliAlWA5mbdH5TptFzfb+Jnkg95+GaMBkGVkN4Kh48ztcVicnNxe5B9I+v
        Mm5m49wU7+fXz0Due/uBXj3sbz9iQyw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-nv9_nTFzO-yxgD4LgVR22g-1; Mon, 21 Nov 2022 09:03:57 -0500
X-MC-Unique: nv9_nTFzO-yxgD4LgVR22g-1
Received: by mail-vk1-f198.google.com with SMTP id b127-20020a1f3485000000b003b8a69e5b11so3990913vka.22
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 06:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpRiqy0kwVgMdz1yBw1kbEJkrvHf1eUDUqKJWLzJ948=;
        b=zBwLrrrL2RBkZluK2npriyukYwU4r0bfLom7k+zYMuofS7mn8qHKCFzKuMXZhn+7AO
         vJP0o9ESTvtzJBvW7Oi8botWSiZYJ5MSv+6EFdgvZOVmZP/N3yqcOmQ6vR78TzVK8zQP
         iya242S3jIvc6cTXPJEehCM1H+2w5efWiFgQd/ceq/GXDnS/WF4+axKw4Qg1rY/ZC1EY
         +tp9mg+UdaETmjhFHJw6xeMWeTdWbADTewKQH3bT0x/noJPt0wCWiwtyBBR/KIg5x84C
         QaFuY5+3cPH/u6mpo4UACice1R7pwRPdvFAAOrf3ZCCfkZc7Wij5pJPypAfNbokylwdV
         QSgw==
X-Gm-Message-State: ANoB5plILz8GutqaenK08WqPkEAlAXROWBwZf8V46E5yzKP8MuLQQYHf
        CUr+mNCxj7ca+lxfwvqrVVyZPmyUM2mYDMUykfdDJcBCqg66Cq4hxynkua9w+coT+wY0zBvzP1T
        Z3Wij0roTGwDDeR9EE8WCIjqiod8Bl0zAmaO20k7cHZ46Uw==
X-Received: by 2002:a1f:1ed7:0:b0:3bc:648b:eee7 with SMTP id e206-20020a1f1ed7000000b003bc648beee7mr6427946vke.28.1669039436055;
        Mon, 21 Nov 2022 06:03:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Qhw6bXLhldT3RfCnXHJ1orFBJROsMReUYxL7IR80o8yNo/DyYzqXwnWihAbsPrZn9ocfQhTHDbxoAqNk3PFo=
X-Received: by 2002:a1f:1ed7:0:b0:3bc:648b:eee7 with SMTP id
 e206-20020a1f1ed7000000b003bc648beee7mr6427922vke.28.1669039435721; Mon, 21
 Nov 2022 06:03:55 -0800 (PST)
MIME-Version: 1.0
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Mon, 21 Nov 2022 15:03:44 +0100
Message-ID: <CAE4VaGDR+p-KDK6WNnzp5go4r_3Q-OtjR_J2_NpgFcwL8O8KiA@mail.gmail.com>
Subject: AMD -missing perf stat metricgroup "pipeline"
To:     linux-perf-users@vger.kernel.org
Cc:     ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I'm testing AVX-512 packed double performance on the AMD Zen4
platform, and I need help identifying the backend-bound workloads. On
Intel systems, I use the metricgroup pipeline:

perf stat -M pipeline binary

which gives me exactly what I need.

What plans are to add a similar metric group for the AMD systems?

Thanks a lot!
Jirka

