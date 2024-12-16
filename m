Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC9209F5E;
	Mon, 16 Dec 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367541; cv=none; b=eq8sDIYjKbO0dBD+meJiEPcV+YuaP0bZ3EcMt12uxTcAtjzsPYeVJJNdHyGqnf8iee+7XooM56jxxl/dzYsnS4MlotDOmVNa9a5BgMw76DNi+RJVjigFUHboJCeNzfSgrGS31ym7i1CK9MZCswxJh3jqYy0C4y8aColVMLjngc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367541; c=relaxed/simple;
	bh=yJ24TxEgPNvMjTAhmRojKXtL59U+RMUTJ20Up5QjyrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqqca8gAxD/Z5VBHVcr+HsknunkkkiKLOR195P/iTXCGiPZmoio2QzwdtH5rqxzSn4oxrovb1BVFJdxmLm+POBDHxwcj//5LOc/J56BZw5Qzux9V9B5Vzwc4DDrufyWNtDF7JcbsR24nKDX6Bf5zEp1qA+sbjXXBT2273+q8M3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcXXv8yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcXXv8yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE8C4CED0;
	Mon, 16 Dec 2024 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367540;
	bh=yJ24TxEgPNvMjTAhmRojKXtL59U+RMUTJ20Up5QjyrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcXXv8ylnkrd0sV8JeaIYeWzlrladufixxN8T/VHziJHIzqjMAHKeBi2vQesfS3wz
	 PwqXjVG1TTFMqTCdaB0vYkkBg8Qaov6medZ6DZN2/IWOp+auDtvngiiMTDGR7bZTM1
	 RqJUkV/f0YnhcTV6t1b5joBF8AcRPJPe1RNvhapu0Hk843F/WTKj+Wx0IJfKn5USui
	 J7hgfZxP7jtWBTUEsZ6CZmNYcDuhbDsupcCT85d+21BH1rf/Pv3MrqOwMk1KfgLod1
	 vYPCdROT6vN+lGIQz5Xn2+NVYYK+Pdkwc3GmBiyWQoPerSdyHVtyJcrcIAU8vayLAV
	 7llzfc4kFUjvg==
Date: Mon, 16 Dec 2024 13:45:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: kajoljain <kjain@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/arch/powerpc: Add register mask for power11
 PVR in extended regs
Message-ID: <Z2BZMhDFO-aJ_Gjw@x1>
References: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
 <2907ca2f-b973-42fd-ae03-99732dfda7a1@linux.ibm.com>
 <0402AAF0-5498-48C7-BEBA-2C0B7508D9E2@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0402AAF0-5498-48C7-BEBA-2C0B7508D9E2@linux.vnet.ibm.com>

On Mon, Dec 16, 2024 at 03:32:12PM +0530, Athira Rajeev wrote:
> > On 11 Dec 2024, at 5:32 PM, kajoljain <kjain@linux.ibm.com> wrote:
> > On 12/6/24 19:26, Athira Rajeev wrote:
> >> Perf tools side uses extended mask to display the platform
> >> supported register names (with -I? option) to the user
> >> and also send this mask to the kernel to capture the extended registers
> >> as part of each sample. This mask value is decided based on
> >> the processor version ( from PVR ).

> >> Add PVR value for power11 to enable capturing the extended regs
> >> as part of sample in power11.

> > Patch looks fine to me.

> > Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
 
> Can we please pull in this patch if it looks fine.

Sure,

Thanks, applied to perf-tools-next,

- Arnaldo
