Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291306;
	b=mgeKCU4LZrKd4wqHCkvWuNVwgBnWpPOUowVBkE9APa/QDCVbdh047RGlJUftVga7xib4
	 iY4uqjGgy+9Qcf+wEteQ+xSfrcyY+Q1rixOW8Q6Nj0EAfbI3zbT2vQHb95HzZW5Xz5gXB
	 /FUdVDILt1adRSx36rdKi5x+xa6DGnhoFSi0T3Yy2aVz+9U+2S6wlmc5tkdbo/PZ9nUTp
	 Tr6kQuG4wrqSUN/60p0oH/GVfMlmd5nQ1xU1KZLav+5tf+QUO9TXhNtRRacsYNzt6YNLz
	 OCfqb9KaCr7ooaNGRszurfOFgxVwqh24+HFiFU900X7ctFnHxoyyCs0JmT+8ahxFDXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291306;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SVlNIJ0m9KSL5RpU3jpMg6g2yP/IAuLk6Q6u60owZeI=;
	b=YUT4N0mOpa4E8OnFPGOnCWWt+jao8r/neDg1EzCe0nIiFBqJS8DI/BvFtjRcObwAkOh/
	 J0sq8wlBD22RWyOE1tRywkV1pzjf8wtVBeeBLGnbg2CdYKPhPqAy8CQ2GBt86yTkEk4Hs
	 GloRkbkGZImWsX7WZuAZ2u2OyL6PG62f1RQS7UaE2bzZeKKMDg4a4vBLhk4xg8+t1UnpU
	 kB2cC3IeHgludFYa+wMguHK/AU8SbyadSZAt7TH0JCM1gvexoQRf2voPBZgFFZDRILdYO
	 HCOb0Vi1cDClYYIi0jUIc07P7AJ5mDpUc77h6ldIKit43omg+adE/Q0nzIsp6kyrrlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nN6JY19m;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481CA606A32C;
	Thu, 29 Oct 2026 16:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481CA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nN6JY19m
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 398CD1682;
	Thu, 29 Oct 2026 09:28:21 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6CF83F673;
	Thu, 29 Oct 2026 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793291304; bh=IlWKCr8cNX3eq8NiYg9hKE4gBjr06Z9/SknZ4Ts7Dxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN6JY19mfyUMqvluRTYDrKSmxGyf23n6H2G/YVGdfW8NXXJ2J1wnrs7Umo+RKtKzL
	 09W89bxYqPu/lm7kLuFKY9M5R6uriETsId7sDuSOFf9hNZGtVCiASjdsMGXUXzmKzP
	 0F9FMrok57JscYGM7QjbqyCCYCB7beymYG2bAgsE=
Date: Thu, 29 Oct 2026 16:28:21 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v2 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
Message-ID: <20261029162821.GB9176@e132581.arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
 <3852b153-9be1-4ab4-803e-cb8a6de34879@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3852b153-9be1-4ab4-803e-cb8a6de34879@linaro.org>

On Tue, Sep 29, 2026 at 02:55:28PM +0100, James Clark wrote:
> 
> 
> On 23/09/2026 16:21, Leo Yan wrote:
> > Use packet->last_instr_size in cs_etm__instr_size() instead of a
> > hard-coded value, allowing the decoder to supply the instruction size.
> > 
> > Keep per-address decoding for T32. A range can mix 16-bit and 32-bit
> > instructions, so last_instr_size describes only the final instruction
> > and cannot determine the size at an arbitrary address in the range.
> > 
> > Assisted-by: Codex:gpt-6
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/perf/util/cs-etm.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 2d1ab34f7b6b5a6331005c16c6a418d123c815eb..0163d93ac2d537a2190536e77d24628b4d707751 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1358,8 +1358,7 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> >   	if (packet->isa == CS_ETM_ISA_T32)
> >   		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
> > -	/* Otherwise, 4-byte instruction size for A32/A64 */
> > -	return 4;
> > +	return packet->last_instr_size;
> 
> Why not use last_instr_size for CS_ETM_ISA_T32 too?

T32 needs per-address decoding because a range can mix 2-byte and
4-byte instructions.

> I'm wondering how and when this change actually makes a difference?
> last_instr_size isn't any better than '4' for any instruction in the
> range other than the last one, so it's not clear what the issue is.

It prepares for the later patch that synthesizes exception entries
separately, where an exception packet can carry last_instr_size = 0.
Preserving that zero avoids advancing the reconstructed return address
by four bytes.

I will update the commit message for this.

Thanks,
Leo
