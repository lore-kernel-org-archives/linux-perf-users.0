Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0722D8379;
	Sat,  8 Aug 2026 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149903; cv=none; b=R8L0fTMVajgMSu12ckA71cvBC/ctWVNkMjjDKXKHu3bDCyv2/JY0+zk0cL3xebpafQAVe94xX/DKbh1RKyh7u3NZ9h6jbq3Wsk4WzGt06j4gWYqhytgcMkHerwzt/Whfaq2Bv4vT0tzjaVBQ3/+v9/DrHBRLPD4Xp2nkDuuHQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149903; c=relaxed/simple;
	bh=Wnvt2uvVNiHYoDyjifQgqfm9rMgcZp/K9dzkDkwslXY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pTRwWocZppbk3rytnPbbbBgLvtsMe+h23d9ose794W1br76WaIWrijdDJ+YWIJp9zvIgfz0ZrOtOxnM20rs6wK0FlH4I1VXywPFIz6QEop9/mWXSg08IUJr/7LWiN4ORSgWShl4waZrPdUIvYNgE3R7EX03zBhsi+eXz6iEQmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEZR9FYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEZR9FYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0D1F000E9;
	Sat,  8 Aug 2026 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149902;
	bh=o6rc0mXWsY6/K1ldDEszmUHwAu1WzPiAqosXbNFO1Fs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mEZR9FYhPVQi9OEoX82qZV8WuvXELMbvymWxy/n4z094hX48TbK/9pRaUAX41rFjL
	 YXyGrOSL0Ss+HPoMrdfgMn8b0IGCA86TMRJxD4d4eZJKETEqPPPnqHYDyHUdPoE7xu
	 WN0Tn7y0rwWU6A2uD0fNsIwWMsSuf581JpdvshKrakQuPGOP1GQDd1/D2rmMZxPn18
	 LZb5X/ZBJ0IFt9sT5A2UDs0s+CvhPHRROR209EAu18bjeg/NhqCTC3FsoBAYGN4q8N
	 GNhZiEB3cZJSBpCwu80ZxYhSfOCtLZkVt8y+IXnZ3M8en8lfGCRTjVcRWoCMNhPt18
	 x/H6ZltPEUUwg==
Date: Fri, 7 Aug 2026 18:45:00 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, 
    anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: RISC-V: check cpu_hw_evt before dereference in
 overflow IRQ
In-Reply-To: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
Message-ID: <9109b689-1145-c714-ebe0-ec368f242a78@kernel.org>
References: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 7 Aug 2026, Xixin Liu wrote:

> The overflow IRQ handler dereferences cpu_hw_evt before the null check.
> Move the check first. Defensive only; the cookie is valid on the normal
> path today.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>

Could you please add a Fixes: tag?  Also, if it was written with LLM 
assistance, please add the appropriate Assisted-by: tag.

thanks 


- Paul
