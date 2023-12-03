Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvmX0WX5"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08867E3
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Dec 2023 22:14:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2866951b6e0so1316515a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Dec 2023 22:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701584044; x=1702188844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=USyvH5CutrKzFubmRpisjGv4lda2nBk/5nqYGwGadMU=;
        b=BvmX0WX5aVspC4ifTKijMToSm1mOE+ZvtnWyciGXEPk4JoY81kRI9CdGGuJZt5rp3M
         A94TZdJEaCqMhC8hZcdVHXeZtF1Wv3Bj27SyqRS9QHcf+rHxF9sQlkkChRGPrPZAyY72
         E1CfxTPtQoXxRfROVbvdZI75cc2IgbAW9FDVgbo8ifV5adW6aksUF1JQKzzDGuGwpypt
         7QfWLbabVJvkuAgNqUUjfkiIu1CwIU5A7Qg5SKxJCoY2HWtOcg4vJy4KJs4hcp0N2KUU
         JcNbMCLEFcB21cMdKcZaVpxsfpIE3hoSRYTKU9Gl6uObpEPZ4Aq2n+f+l48LnEVkK/+v
         TufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701584044; x=1702188844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USyvH5CutrKzFubmRpisjGv4lda2nBk/5nqYGwGadMU=;
        b=DOR5f8Fp3lEPTDIj3mAkVkJv+8ldSlcZ46z1VaRnB2kvw6ZSt9ngc6ORbZso6numxx
         mhR6fXi39p+mg8hcvGltauQZLhwkA1B2tFVTEObo2SlyRDDJEAXXM014i73pQGqn8eRF
         4eTKcHblGxfQ0TQE53navKBpAyYqprA6P+D9yGg1pW8wUkpeJNO2K4Rtqe288y/dRrtn
         ETltZZ1mTf+QdGv2fbJYJgVLGAuyX7vvam1vTo4a5BB5dcDxCzsFlJgjBuyrgvTRgfJz
         JgxItUTX/PjWE9RMvM4LTL7Yw0DVSd2BVrIpAklGyuseoL+2sd3vA33aAPXlQoDmLR2Y
         cAZQ==
X-Gm-Message-State: AOJu0YxsImv+tOkz9NTBeNxF1Ii77YfzOzlDtIFirA+ra3+FDKAmvht3
	LeX31M5JPoHCNyOPeT/u7BNmEw==
X-Google-Smtp-Source: AGHT+IFZDKXJjdVyw4Mw/K7Vtk3CCkmIf7ahLJ8Txg+438zRp8/9ZSK+sY9Ag415LqZEIKEHSipb9A==
X-Received: by 2002:a17:903:2312:b0:1d0:7844:5055 with SMTP id d18-20020a170903231200b001d078445055mr1842801plh.62.1701584044093;
        Sat, 02 Dec 2023 22:14:04 -0800 (PST)
Received: from leoy-huanghe ([98.98.115.171])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d087d2c42fsm751908ple.24.2023.12.02.22.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:14:03 -0800 (PST)
Date: Sun, 3 Dec 2023 14:13:53 +0800
From: Leo Yan <leo.yan@linaro.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com, james.clark@arm.com
Subject: Re: [PATCH] perf test record user-regs: Fix mask for vg register
Message-ID: <20231203061353.GA19079@leoy-huanghe>
References: <20231201194617.13012-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201194617.13012-1-vmolnaro@redhat.com>

On Fri, Dec 01, 2023 at 08:46:17PM +0100, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The 'vg' register for arm64 shows up in --user_regs as available when
> masking the variable AT_HWCAP with 1 << 22 returns '1' as done in
> perf_regs.c. However, in subtests for support of SVE, the check for
> the 'vg' register is done by masking the variable AT_HWCAP with the value
> 0x200000 which is equals to 1 << 21 instead of 1 << 22. This results in
> inconsistencies on certain systems where the test expects that the 'vg'
> register is not operational when it is, and vice-versa.
> 
> During the testing on a machine that the test expected not to have the
> 'vg' register available, the perf record with option --user-regs showed
> records for the 'vg' register together with all of the others, which
> means that the mask for the subtest of perf_event_attr is off by one.
> Change the value of the mask from 0x200000 to 0x400000 to correct it.
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

LGTM, except I think it's good to add fix tag:

  Fixes: 9440ebdc333d ("perf test arm64: Add attr tests for new VG register")

With above fix tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
