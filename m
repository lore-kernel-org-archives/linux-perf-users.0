Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF412E847
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTtDjzAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8262BC433C9;
	Mon,  4 Dec 2023 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701718419;
	bh=Bbi2AEe0ruXNva1PBZVs8s56Jfw968QWn2BVVWXCTEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTtDjzAxWDHClc/AvrJCC0tDnUqT0G1rFB24jjbyp9RBzbixNzzdC8n7bpo3fJFiu
	 gepzPEyyHb0qTs52XpFfcv+qSR96Vk+Hwie2Fu+jI40CO12lgZSysRfmDgjuCT9jZ5
	 Nf4A29gZhRe8Ui/x73fR4L4+MqZmvOvEREYS7FkS0XgURcJ10PNOgKTV1o36JgpJM3
	 ZaMLnz71ixHy77Vfhs4fEE/7zPKPi6nY/7GJWZSb6TGTg8/ai0MgnR6bPQNn3ddG88
	 yi1uKHC70CY/0hPRR0WJwU+0IhlthtufD6IUOaA8qaOK2YAgY59HP5Pa23ATEcKqMa
	 yxZ6//0006m1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 05F4C40094; Mon,  4 Dec 2023 16:33:36 -0300 (-03)
Date: Mon, 4 Dec 2023 16:33:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@redhat.com,
	mpetlan@redhat.com, james.clark@arm.com
Subject: Re: [PATCH] perf test record user-regs: Fix mask for vg register
Message-ID: <ZW4pkLRGgfA7zotm@kernel.org>
References: <20231201194617.13012-1-vmolnaro@redhat.com>
 <20231203061353.GA19079@leoy-huanghe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203061353.GA19079@leoy-huanghe>
X-Url: http://acmel.wordpress.com

Em Sun, Dec 03, 2023 at 02:13:53PM +0800, Leo Yan escreveu:
> On Fri, Dec 01, 2023 at 08:46:17PM +0100, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > The 'vg' register for arm64 shows up in --user_regs as available when
> > masking the variable AT_HWCAP with 1 << 22 returns '1' as done in
> > perf_regs.c. However, in subtests for support of SVE, the check for
> > the 'vg' register is done by masking the variable AT_HWCAP with the value
> > 0x200000 which is equals to 1 << 21 instead of 1 << 22. This results in
> > inconsistencies on certain systems where the test expects that the 'vg'
> > register is not operational when it is, and vice-versa.
> > 
> > During the testing on a machine that the test expected not to have the
> > 'vg' register available, the perf record with option --user-regs showed
> > records for the 'vg' register together with all of the others, which
> > means that the mask for the subtest of perf_event_attr is off by one.
> > Change the value of the mask from 0x200000 to 0x400000 to correct it.
> > 
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> 
> LGTM, except I think it's good to add fix tag:
> 
>   Fixes: 9440ebdc333d ("perf test arm64: Add attr tests for new VG register")
> 
> With above fix tag:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

b4 even collected the fixes, that I checked and is in tree, etc.

Thanks, applied.

- Arnaldo
