Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7548C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F10460FE8
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhJHP75 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 11:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhJHP74 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 11:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633708681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t/gpoal7kKHASLhUxUzEdo76jxdasCN4foB/2JL1Ha8=;
        b=Y0B4e5POTphWDJ595XqupZ9mgvgn7E9zTlg2MQU1PHq1F8nT1SA3WQ/AmRYfID3ah6j7mP
        Dxw1AHyfWv2HdiAu7SdaGfDG2G7Vgd1I6eTMGDyoz4+r27ix6e4QvJY9TVhk3Kxd+bSk05
        RWNCs2iNjHX/SfFRSeFZUPPAZsvktpQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-rDm0gigMPKy7FJHtqoWD8A-1; Fri, 08 Oct 2021 11:57:40 -0400
X-MC-Unique: rDm0gigMPKy7FJHtqoWD8A-1
Received: by mail-qv1-f69.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso8974415qvf.17
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Oct 2021 08:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t/gpoal7kKHASLhUxUzEdo76jxdasCN4foB/2JL1Ha8=;
        b=3Xujr2vvbRwe8QIAY/ESyKNHT/oms+KJIsYhwdKCApxth7BFpUS3Rbpirh62JVidaL
         jeJXARn45mHzeEs7359jdUVwQ19CgmdWMOf4w6eUdu3KHYRkr9DUsyO5Ws+04lcNy8eV
         cn0xB24aGNCEiXfljS/H36NuW6PAv/+Vj1ZxZKOwlUafKN64wxTe2LFI+lsgEQH6ChIY
         84+JpH7CFpZAJ0S5qpxCRzRcTLK/vKiz6Ax8WTIWhelD4bXIgJ+tD1YLjGyVFgt0jrqx
         tdjjpoMG4MjltpPk/4g+i7q6S9Aw6vEgP4RDtszBdgN59h+kgxZCKqggckKt8aOqXdus
         Hufw==
X-Gm-Message-State: AOAM531gMr9whbTaBRw9VZIz55a+ihPc1os+cpVW4J+47IEjgM7aZKFQ
        qVcXnXSWnuQslWwWU3EARgVVrNxfQyCPXPcsR1RzMN4nES355ldWKXTgUuHDcktTkgTs+HmBI2y
        eG+/C7yOwKVyRHhwOOI7q800W0BAlxg==
X-Received: by 2002:a37:9f12:: with SMTP id i18mr2534308qke.418.1633708659564;
        Fri, 08 Oct 2021 08:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg2I/69KUy6O7gFsSHZEEWkE1gAXdSLzj/8Thl/yOzGCtB/DJJpbarmdQv//TzyS60AoPsUw==
X-Received: by 2002:a37:9f12:: with SMTP id i18mr2534297qke.418.1633708659393;
        Fri, 08 Oct 2021 08:57:39 -0700 (PDT)
Received: from [192.168.86.23] ([136.56.129.226])
        by smtp.gmail.com with ESMTPSA id f15sm2696582qtf.66.2021.10.08.08.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 08:57:39 -0700 (PDT)
To:     linux-perf-users@vger.kernel.org
From:   Stan Cox <scox@redhat.com>
Subject: SDT probes 'f' float type indicator
Cc:     systemtap@sourceware.org
Message-ID: <cf658615-9172-6cdc-d9fc-b0b5ddb04a8d@redhat.com>
Date:   Fri, 8 Oct 2021 11:57:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Just an FYI that support was added to the upstream user space SDT probes 
to indicate that an argument can be a float argument.  SDT probes are 
recorded in the .note.stapsdt section and the syntax of a probes' 
argument is:
  [-][Size][f]@[Address]
where:
  '-' is optional and indicates a signed type
  Size is the sizeof() the type
  'f' is optional and indicates a float type
      This is a new syntax feature
  Address is typically one of:
   Literal | Register | Offset(Register) | Register,Register |
   Offset(Register,Register)

