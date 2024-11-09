Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9551537C9
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170237; cv=none; b=DCqeAVuMGXBR1NR5EJ1Ey+dwdPu6x572fddh8e1kVv6av0TAl8uJn2fvIMbdSTEzeZK69kl2vnmYsP1MCew+GyXxwFLURwvOIatanYIcX6iDHjwUsu0+1d9rdXr9QC+9iEQV4qQqm4FAK7R0KpjKZVnEVOp+mwWJDVRsYvOqPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170237; c=relaxed/simple;
	bh=KmrkR7SY2XfMX1n2JutVpNklxzuRHWektyFf7oAOTJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pOsObhwJsM58SD1m7ly6SRVhCeof5wrnxEgP3RgnB2f3379f3uf5Gr8xVnFJ5V+yrtC4e+qXUgR7rzwcpDj0ahYJCmArqCqafaGUTo2QCgMTmR36BcrHeTAKewWybvQAayYJFjPfP9O67r6ypG8sNl58aq2eXFfZwu5iZkkLfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlme5mmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlme5mmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF46C4CECE;
	Sat,  9 Nov 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731170236;
	bh=KmrkR7SY2XfMX1n2JutVpNklxzuRHWektyFf7oAOTJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zlme5mmFAq2nGaQbpRgioe+nI3wFR14MKsDaqgt+SP9s08LNstW9ZJzu0HMDvxvIh
	 u3B54+/MZ2KPJPbMW1BwGPNmaoJZOpK3osh7MnJ13ZDI7GmZZlWV0CqGbbmcQAvioM
	 nMJ5+8AVr7+BnaOft620skl7c/1//7pB9eFyyQHslx+/o9YHYej7zGBdmrEcWT+E7j
	 jMJgH853zFImwHNy/3bVGg88gGBG9EjNQajVd6Q1hAs0GQdktq5EAe+noByQUk6+Si
	 r36kcWF8b+90Z6esjjYKI0Ni9ETKkyo63YYikGpHKsQdTBb+L65x3wx4hq6w9V4J8M
	 6PFUFK96yzdzw==
From: Namhyung Kim <namhyung@kernel.org>
To: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org, 
 Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
References: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
 <cover.1731027120.git.scclevenger@os.amperecomputing.com>
Subject: Re: [PATCH V11 0/2] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
Message-Id: <173117023647.3738736.13855747983305853936.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 08:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 08 Nov 2024 12:11:19 -0700, Steve Clevenger wrote:

> Changes in V11:
>   - Corrected prefix.
>   - Fixed compile-time error for perf debug build by substituting in
>     the map__pgoff macro (trace_event_python.c).
> 
> Changes in V10:
>   - Removed errant space in patch file 0002. Passed 'git apply --check'
>     at perf-tools-next, 6.11.0-rc6.
>   - Added back missing prefixes.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

