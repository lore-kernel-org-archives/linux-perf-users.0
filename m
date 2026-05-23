Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42E1FB1;
	Sat, 23 May 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779576282; cv=none; b=oZTRInYzbLXBUBsMAtG7MUM3+q+iF3TvLSNSkz9J0/XhebV+FXLZqX27LOpR4yNb6OiUodCG7qkGMuUanmvpZCfEK5vDoFeDrtE4bWF/GgE0zgC//AS3AN3+3hkgnzWPo08/I5ddAsyub4iJyAW5c41LCyUSgWNNocYf3ZHo+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779576282; c=relaxed/simple;
	bh=2a3l92U7oMlc1CTx1JlHFc++euwbKy/QtJhml9688lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmAbE3yFj38w7rmkCD1gWbbyXsZdUDFbfiONnx1XTPKLT51O7ngLvPGMVIFGiQOJS9Gsxlic95VQIRKDyyq1pMRV55jjj9sv/WMlBt5sO6ZbKpDf+zmN7kEWRmmSnjZvkK3cOFx6O9NI50adlGoy45eH+xXeY1ASV0lAiR62Tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuiRxfMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuiRxfMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191671F000E9;
	Sat, 23 May 2026 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779576280;
	bh=Ly0RA4VR9deG/+GQfcotwpWhgxpylLFnae+5Pv9ttM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kuiRxfMAnmum87HB0p5Jf+HbK3f+Q6KJxqfksoT3Z1colDAfSu4CVUnK6DwY3uzND
	 qAo9Cvv2OmNGdbwQ/j0fGuYPxYuDJ+PXH7cCI9EUmJrslTkoRmXeVuT3lLh5wtc2ZR
	 BJhhQs3WY3uIpesOKy7tguT6Cb8M34q07ME530AvdFCvlIHbz49m+ERnbnp+oDlFol
	 MeTqUlIf1SIFFEhXpf9y9H3eiXMAV50ih4UYDs7QUMkfHVT3vW63j0gAv51pa1nXFX
	 8124VZO1ljYRsB/7HbMBQnHqtBR6ZWiqY9JVeA8k0277L0VUa3/qz79Kij8MrTaW8G
	 0qdwvc8C3dFIg==
Date: Sat, 23 May 2026 19:44:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	palmer@dabbelt.com, pjw@kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf riscv: Fix discarded const qualifier in
 _get_field()
Message-ID: <ahIt1ArEyRH8HIXf@x1>
References: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
 <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
 <6f54fc06-1a75-4910-82a5-172a42f34284@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f54fc06-1a75-4910-82a5-172a42f34284@isrc.iscas.ac.cn>

On Sun, May 24, 2026 at 02:41:26AM +0800, Li Guan wrote:
> Hi Arnaldo, Namhyung,
> 
> Just a gentle ping on this patch. It has received a Reviewed-by from Ian.
> Could you please consider picking it up for perf-tools-next?

Thanks, applying.

- Arnaldo

> Thanks,
> Li Guan
> 
> On 5/14/2026 2:07 AM, Li Guan wrote:
> > The assignment of strrchr() return values to non-const char * variables
> > triggers a -Werror=discarded-qualifiers warning when building with GCC 14.
> > This happens because in newer glibc versions, strrchr() returns a
> > const char * if the input string is const.
> > 
> > Properly declare 'line2' and 'nl' as const char * to match the glibc
> > function signature and ensure type safety. This avoids the need for
> > explicit type casting and aligns with the design pattern of not
> > modifying read-only memory in the perf tool.
> > 
> > Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> > ---
> > v2:
> >   - Drop the auxtrace decoupling and weak stub approach as they interfered
> >     with the cross-platform analysis intent, per Ian's feedback.
> >   - Focus on a clean fix for the const qualifier issue in RISC-V header.c
> >     by properly declaring local variables as const.
> >   - Use Li Guan as the preferred name format for consistency.
> >   - Verified that this fix is not yet present in acme/perf-tools-next.
> > 
> >   tools/perf/arch/riscv/util/header.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
> > index 4b839203d4..891984e909 100644
> > --- a/tools/perf/arch/riscv/util/header.c
> > +++ b/tools/perf/arch/riscv/util/header.c
> > @@ -19,7 +19,7 @@
> >   static char *_get_field(const char *line)
> >   {
> > -	char *line2, *nl;
> > +	const char *line2, *nl;
> >   	line2 = strrchr(line, ' ');
> >   	if (!line2)
