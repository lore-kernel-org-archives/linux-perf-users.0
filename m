Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FAC07E9C
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B3E61CA8
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 21:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGFVId (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhGFVId (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 17:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625605553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pCkeqTi9Z8pnCLX4xKb6CHs6Mz5uaIewNQ5zoX9f/k=;
        b=FchJAjcI+qfFQhnyWvqd75jNbnmpaRGkrvaukQ3o0lBq22FBUJa9d+X6U+hVnGzPh66cyi
        zYz9MC3Kw3M8PzBHFyJOCjUb4K/8DAUmQNMPYJy8beoi7pPhfNHVb5I2pbiQtmaALBY9rx
        FX1Fr/etK3aSZudUwJPn4V5kUjCegyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-B0KMZUQ1POuy5oJ2EZBD1w-1; Tue, 06 Jul 2021 17:05:52 -0400
X-MC-Unique: B0KMZUQ1POuy5oJ2EZBD1w-1
Received: by mail-wm1-f71.google.com with SMTP id m31-20020a05600c3b1fb02902082e9b2132so1590341wms.5
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 14:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pCkeqTi9Z8pnCLX4xKb6CHs6Mz5uaIewNQ5zoX9f/k=;
        b=lHKqVXGLVNbCEX/DW+4wxJVgFLMAZTNfxtHx/r6fjUEWxdaUlYfOB0WaBTlKDli8g4
         22XWsConIcKYMWW1ImCZpdSA04cvtu6u0W0LoNYta06++SgdabFSyylMp9/eQ7TbkjCl
         i3aNw5poTvFOcpn1lOUrJmvR7HwRIxlNfCUou+OORNwNqZE03IPyfQL/UVnRb+osiQGz
         +sazcZUBviSjLnfT3zJQ5jAkDeA/mkBkfjuze9xGrI/1W6LiHqzfIujOb3fAv7r/lak0
         SwfM1vtuYBtCDfkElSZSf4sJBIIRLx+M56YUQpBZA/MfJGZdsfk74o4Ns3eIIMcabC1f
         IDLw==
X-Gm-Message-State: AOAM533UtV8BAo0qRbkTt+QWcSUpQoF0ASOrKJdoT4QqR4E1Do/rO1CP
        q1M3lVZan65Gd01Sie6lEKBWkJcU7Pha/KZ/CijpFIVEgy4Q1yyl8sgwX3znVEdKwcO9fHiup+B
        G3NN0DGpTHNEAhLb0fe9rAEehUqUaPQ==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr24381060wrq.387.1625605551533;
        Tue, 06 Jul 2021 14:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOhrydYavVx/+sIKU6aLtGvSDAD3WCi7G8LjuQ9+fVE5Y2AH5nCrrkIIkx8wYFJ5sw9P49rw==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr24381018wrq.387.1625605551291;
        Tue, 06 Jul 2021 14:05:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id t9sm18899868wmq.14.2021.07.06.14.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 14:05:50 -0700 (PDT)
To:     Eduardo Habkost <ehabkost@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <20210706195233.h6w4cm73oktfqpgz@habkost.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID bits
 RTM and HLE
Message-ID: <4cc2c5fe-2153-05c5-dedd-8cb650753740@redhat.com>
Date:   Tue, 6 Jul 2021 23:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706195233.h6w4cm73oktfqpgz@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/07/21 21:52, Eduardo Habkost wrote:
> On Wed, Jun 09, 2021 at 02:14:39PM -0700, Pawan Gupta wrote:
>> On CPUs that deprecated TSX, clearing the enumeration bits CPUID.RTM and
>> CPUID.HLE may not be desirable in some corner cases. Like a saved guest
>> would refuse to resume if it was saved before the microcode update
>> that deprecated TSX.
> Why is a global option necessary to allow those guests to be
> resumed?  Why can't KVM_GET_SUPPORTED_CPUID always return the HLE
> and RTM bits as supported when the host CPU has them?

It's a bit tricky, because HLE and RTM won't really behave well.  An old 
guest that sees RTM=1 might end up retrying and aborting transactions 
too much.  So I'm not sure that a QEMU "-cpu host" guest should have HLE 
and RTM enabled.

So it makes sense to handle it in userspace, with one of the two 
following possibilities:

- userspace sees TSX_FORCE_ABORT and if so it somehow "discourages" 
setting HLE/RTM, even though they are shown as supported

- userspace sees TSX_FORCE_ABORT and if so it knows HLE/RTM can be set, 
even though they are discouraged in general

In any case, KVM's "supported CPUID" is based on the host features but 
independent.  KVM can decide to show or hide the hardware HLE and RTM 
bits independent of the host tsx= setting; it may make sense to hide the 
bits via a module parameter, but in any case this patch is not needed.

Paolo

