Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BD9463;
	Thu, 27 Nov 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277140; cv=none; b=pt6i0oRADNb8Pb1ANW6k4keNGs4JBu/jWrIoPep8iEbRvb5FE8WL62hxO3LD4OZ/B1s029lPpKq8DIlaH76seIA7SRx0v1X74Hmqg4yR/YAaHoQwCLXt48BHIuX7DRNnXcsBrjPdD8ruKoSY2Zck3d0tn+dj0FkPQr2iFQX/jXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277140; c=relaxed/simple;
	bh=8qXLl43reLBtbzmBTNWDE4MJUHwA1dop+9l0UdnkVco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N/CRdngGnY5njzz7W9P5skKftya996IQMtyaikgTEkS+XXDOG34n1vO6aXKpSoMWaucXa1+AREz53aqCUdL4wpttL8uv5g3orPeDM1bVX1IZUl+XA4UyJjfYfGIBjyRbIG8rqI9OFyO0nSvz2rckE952WMZgDNLnOScJeIbCYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiT4YQsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiT4YQsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AA7C116D0;
	Thu, 27 Nov 2025 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764277138;
	bh=8qXLl43reLBtbzmBTNWDE4MJUHwA1dop+9l0UdnkVco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TiT4YQsyCoy8TZK8P1AxQqBRVTpAC53msertu5McSZHEDZ+3VVMob5QbHkcereSMU
	 6z+Mufs6hvu9uXPi3bm6N4n2vfE/J4xr2vDzL1WfIF9NvgnbYPhxQpGa7mhSsdKVLG
	 wXz8c7zmgLC1yMP9i6eEkGYHPRKpMpTC//WFqvwaMANny7hZKYPIO+XWIEmD0ebTIX
	 6oVKqFEK6OnJ9fH/PRC3WymYtvoYC2+VH7oY9D8HD5NNC0arGENMdy3g782MTRqxxJ
	 vtdDfIsxccJsUtXaFy/olLDKq2Ffd7BwrMaojntz325AzhCfMh1BXCKCsh5EeMkxyI
	 0mbg0bhdKQWjw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, 
 Eric Lin <eric.lin@sifive.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
 Longbin Li <looong.bin@gmail.com>
In-Reply-To: <20251014014830.613399-1-inochiama@gmail.com>
References: <20251014014830.613399-1-inochiama@gmail.com>
Subject: Re: [PATCH v2] perf vendor events riscv: add T-HEAD C920V2 JSON
 support
Message-Id: <176427713670.3725736.11717672882692868206.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 12:58:56 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 14 Oct 2025 09:48:29 +0800, Inochi Amaoto wrote:
> T-HEAD C920 has a V2 iteration, which supports Sscompmf. The V2
> iteration supports the same perf events as V1.
> 
> Reuse T-HEAD c900-legacy JSON file for T-HEAD C920V2.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


