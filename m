Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD93932CB
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782687; cv=none; b=HUlJyjpvHgaEaarUZ6XkjyJ5dynvPnFsV7OeswWeFDgHAqZEn+jmb5mpdjwiZkcR7paa+onfM1yUL2QOQcHKcKJhpgRzUrE4FKTPkB3/AV7mU5OqsVHKbF4BpKEQxHldOZKW4QOleiWwR1H99p7C5Cb8FuMWlx1hO/qcW/DGHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782687; c=relaxed/simple;
	bh=D1x5fT+4M3h9A+n3GevBUFwrT6mX2gnVVGmoS4I2vSY=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sPWub7Uh8fweCk6zUJMnp4xzyfw0vUV0qUc7y0Ya7REQAhmnHwAVD/DeJ8AnTBkiybRtRE4T7lBNeL76I0TKWykqDLxVxVhe5n1PeyauarbndeGe2VhnfuB+wnZyeKu5eTTz+tVG1PRkmr5tc6mN95XuIdu6kZNoe5aHdSbNsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MG1vHEY2; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG1vHEY2"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7e06cbc08d6so21728832a34.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778782685; x=1779387485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Maojrdkd+5w2XWqqGc/P00CzPWv+6mS70oBhALVRgBY=;
        b=MG1vHEY2DOaWbE2yUj5Z1uoklRrKNislzb9UTDmPgHV9qScfu6/gF+U9kuvqSh+PHY
         5r5djp7dhJ9aow66MHDzzbovcOh8ZuM9aNfMRLyXz/0zW4U5LUm90lQiPxjZX5GzkYOU
         KKLdVf4LSBP5934EohQal8XQb1mU4nDUUsDLXxhpDfY6ubY4XZjSza/9UGJBpGYWiuDE
         N0eLNuypozI9q2LGp6omPhq7pmtq9vEvvsbVQoXNkFTnfi9Mqs5XDLHf5GIoIO1RZWl6
         Xzpz2/W72eNAMjamryIOsqJxMjK7P/GQ0l9bLDhlymmYHxAP18+l+yKP4V0ZbJzbdiSa
         0yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782685; x=1779387485;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Maojrdkd+5w2XWqqGc/P00CzPWv+6mS70oBhALVRgBY=;
        b=SdCnhGMEb0puRheCQxHo75whnQpfcNmdaaj9RpBx0fNAa0NPg9bBaGwIPT4pc7GKdj
         vbl3gIlDjAMT9BEJKENYtZhvjndL/NIeU4c1MzqpMYkfNYL8hnwiVtQb7aBMuMQjSF+9
         w10Hsi41fiZ3krCQquR68w3r+3Yb+Ij9unrZmq2cABByJOWMoDQ7mKQINPBTcyvggIzQ
         mWTuCs0FljwQOz5tVzk1F4ggCz6VwOnSxcp837HsGnMZW2h1oXAdE9kY/zAxwrtykO/C
         Ynn24wZT4/p5RvJXL1iBIaqXHrkszn8Ycuuqi36DimckcMbpYzkz8Z0/Swvo1kc/zAYP
         80lA==
X-Forwarded-Encrypted: i=1; AFNElJ88MyCAnqCQvrhqYhLN+IGgbq5LYBWijSCSK9xRYgLb1FoikByAM4SQmc0F89ebd7u67E/pTs5e0dvW3riRkwbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzot3KmeVC8yi1PuwmWd8/lsDDo2v2f6kbOWXKd/z04m+9ozCl
	BkfetFFT1B/dfolqkCGCnA9VhjMx7pTWMfalHzgS8FLRa9Rq00AKZkW64dbk0jQmVxirmOhQOUi
	fbpgk2FNUE29HCRt4k1tr8ruSCQ==
X-Received: from iobhm2.prod.google.com ([2002:a05:6602:f42:b0:973:4a64:ab4c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1746:b0:684:bf61:ed25 with SMTP id 006d021491bc7-69c942e1b26mr401033eaf.19.1778782684266;
 Thu, 14 May 2026 11:18:04 -0700 (PDT)
Date: Thu, 14 May 2026 18:18:03 +0000
In-Reply-To: <agQsM7XFsbxbFRLO@kernel.org> (message from Oliver Upton on Wed,
 13 May 2026 00:45:55 -0700)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnttss9c0tg.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 08/20] KVM: arm64: Add Partitioned PMU register trap handlers
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	james.clark@linaro.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Mon, May 04, 2026 at 09:18:01PM +0000, Colton Lewis wrote:
>> We may want a partitioned PMU but not have FEAT_FGT to untrap the
>> specific registers that would normally be untrapped. Add handling for
>> those trapped register accesses that does the right thing if the PMU
>> is partitioned.

>> For registers that shouldn't be written to hardware because they
>> require special handling (PMEVTYPER and PMOVS), write to the virtual
>> register. A later patch will ensure these are handled correctly at
>> vcpu_load time.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> I'd prefer an approach that provides a single accessor helper that takes
> a vcpu_sysreg enum as an argument and internally handles the dispatch
> between partitioned and emulated PMUs. That goes for all of the PMU
> sysregs.

That seems ugly to me. It'll need a giant switch or two to re-dispatch
to the correct sysreg handling when we were already dispatched courtesy
of the function we are in.

Are you thinking:

single_accessor(vcpu_sysreg)
{
         if (is_partitioned) {
            switch (vcpu_sysreg) {
            ...
            }
            return;
        }

        switch (vcpu_sysreg) {
        ...
        }
}

or I could do the switch on the outside and duplicate the is_partitioned
check but that's the same as what happens now with extra steps.


> This will help you reuse some of the PMU emuation code that you'll still
> need for things like nested...

I'm not seeing what you mean. Could you explain further please?

> Thanks,
> Oliver
