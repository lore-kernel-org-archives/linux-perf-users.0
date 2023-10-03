Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3F219FB
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 14:37:11 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3202AD
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 07:37:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso14235a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Oct 2023 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696343823; x=1696948623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H71Ddp0doyGgICoMWyxNf2GnEn07JdKBfrTYW/a2tY=;
        b=DHY/802L91Y3bsbXfEh4FN5smepxNvCcp0/hs4yiqKQB6i88Oo2ZeXqrQZDX3BlwfE
         51tqquR1UvGRAiR3n6X/s2ZSxok+tB8MokJIqda8j8ARfuYJ15XAqL4wFuaS0ivAyHRk
         qOZ/OiSEGINuKHTFYUdqOSWWufiyOcWQTFcVCIeESWc0kPHDIwk35IV/tR5YokRSci2y
         5xLuOwiRuYGfIOOnf3XUNdEEIKaxYwMr3Nyqgxyw9swii7lPxWV0FcAyDO1zso5YnMts
         hacaY6IkFSkOd/GNdAgj7Zfvve4BD1IdYptjoz3DCjQxZ/l314z6Sau0FVIMjm/Y0szA
         UVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343823; x=1696948623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H71Ddp0doyGgICoMWyxNf2GnEn07JdKBfrTYW/a2tY=;
        b=WqxbuEv9uaKhkqD1D19BUbRWDdCNV+Bdw+aCJ2f6AocJH8mSXypcYhhGZLTHqGkttc
         NWXampj1Sat/etrF+KoRR6VoXo4t/01lPB1W/GOE0f3COXhHix3mKubKR/pWtHWNiO4J
         05ZfIuk1pDSgDbbyI0LilGxCkZNIJMG7KE6ys15FiZ8NoBW2gvsG7yealYbxfssVcw0A
         v86xYEGRCiIQ7kAz4I06UUfQeXknmj+sTbKPS4K+ci4qPfNaJl2EwInMZTo5n8YSNVow
         rkcr5kmlferSl7ouf2StfsFBfWmMdj9RMbgTnkxyH0NWX70Az9rTbXOVXS/XL3HBBGh4
         D13Q==
X-Gm-Message-State: AOJu0YxlpwV8LEKvbaCURezxhk+ROvxDT8IvokvXAwICnrQf5f0F6oPW
	ALgCMj7hhdsf2bc1Ga2xT5G6xeXgHtaKopxfaJ4JXA==
X-Google-Smtp-Source: AGHT+IHXc3WAfKlNdinaDDcPUvQoOeQzdqAXe81rxIcxpa0Ed7oQHIWBrnmmMckOGzulalTSLX6S1L1E64CkioL5uRo=
X-Received: by 2002:a50:d09e:0:b0:52f:2f32:e76c with SMTP id
 v30-20020a50d09e000000b0052f2f32e76cmr137455edd.2.1696343823200; Tue, 03 Oct
 2023 07:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZRwcpki67uhpAUKi@gmail.com>
In-Reply-To: <ZRwcpki67uhpAUKi@gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Oct 2023 07:36:48 -0700
Message-ID: <CALMp9eSozxk-nuwWF3Xvg7fqC5doHKc5-6Nh40EnmzVRX+EQ4Q@mail.gmail.com>
Subject: Re: kvm/x86: perf: Softlockup issue
To: Breno Leitao <leitao@debian.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rcu@vger.kernel.org, rbc@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 6:52=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> I've been pursuing a bug in a virtual machine (KVM) that I would like to =
share
> in here. The VM gets stuck when running perf in a VM and getting soft loc=
kups.
>
> The bug happens upstream (Linux 6.6-rc4 - 8a749fd1a8720d461). The same ke=
rnel
> is being used in the host and in the guest.

Have you tried https://lore.kernel.org/kvm/169567819674.170423.438485398062=
9356216.b4-ty@google.com/?
