Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032C4A7C89;
	Thu, 17 Sep 2026 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686888; cv=none; b=fK6oz81GDJr+iCZ/hch8W/OeMLx8E5gD3lt5y9/xo8n12HpoSVdaGQyVPaPOnX47fatimHFE9YPLdrkg4UDO3tq6pMSk8PYdkmIb6Op5rEs3bODffwUnOQv4ofZYwBxrM2zWONpqq/sICblhNmsk5LiXE/Ca3CFIrumJCk9K6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686888; c=relaxed/simple;
	bh=pYCrWcw3lrxAJ+OWieTP4t8zI2FZctU2xgL9ColGpNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IppLUh6NR0aHw/7M73XI94dWgCX5wUSg90jCZmjclSVjnvNdOn/il5GG77LMDhecA8cok2ztyoZjstVmxirHfLO4wAveBJxaMjIXh60CFLHZpvCxaeocHmH1Ahrbjd5kzvABC5d3HvZzn+DsmPPIAZK4vKVr/tuK4BIp7rVO9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrucO7wQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrucO7wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B841F00898;
	Thu, 17 Sep 2026 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789686882;
	bh=pYCrWcw3lrxAJ+OWieTP4t8zI2FZctU2xgL9ColGpNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JrucO7wQH84Rn0e6U4Ma4FvChc6Fht+ubxUkm8FtIohXaZn917q8V5mZ7sBsi/ohM
	 m8hysAk+T5B3ffTTv5u27a2XlKAlJlcZazBABTftOvcaerr4j3LMbBFhew2NOtx0b8
	 55up55G5NXkE5KgF0qvfKidlY8WMOjf17QCc5HS0EJ+0/a3uNKfY6Qs8ldK2LRJUJd
	 0eJl2/z55SSpWi5TTEvzp3qY/58ugOPuCXZfyKnOIte7MGPFz4Js6PDk8zlxL6E3Yo
	 0SGHqecyAdam3iQr/SAPjg4ZenTkXsUviXTb9co0/Ib9v4C9cjCZtpo4Y63GwOz8mB
	 NoFl/Rms7Xnlg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/11] ptwrite uprobes: Factor file-backed
 instruction reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-6-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-6-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:14:42 +0000
Message-Id: <20260917231442.A1B841F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Refactor copy_insn into a more generic uprobe_copy_from_file.
> The existing copy_insn is still there, but uses the generic
> version now. The generic version will be used in later patches.
>=20
> No semantic change intended.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D5

