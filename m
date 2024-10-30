Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6361217464;
	Wed, 30 Oct 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323848; cv=none; b=NNxb9z0xVxq51//0YuBBAwMPWxyWf0sk43NqFBINqOcjXr1xL8RmJOmONLa7vYtOWtmhHa2uPn/ROkHDLdE/J9SHyLeL2ceSgRysIy/2xl7fqSuTMtcX7Me1gGolADvAs5XCFQbTe6kwKJOYwIdRItyJ7qBsfRnsSdzFJ1onj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323848; c=relaxed/simple;
	bh=BDkqBgG+tZLlXlsjJj/qf+mQTBYkBAhTv9lsJC8G/sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fONgH3LRHas98B+txyuu00W4+FsiqVXJ7Qy1xCV/+N6MZHTW7+36oJ6e+YvzQI2DsogoZBFA1etAs8N+31VGM9ZkKhSPcjtTXR2ttVMT9x413FFUiG0CjYQDnC5vZd0LR28vJNS47zN8H9GkqaBGXn60U9bhoZx+/ac1q7Du5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaF4EJmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaF4EJmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013CDC4CED4;
	Wed, 30 Oct 2024 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323848;
	bh=BDkqBgG+tZLlXlsjJj/qf+mQTBYkBAhTv9lsJC8G/sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IaF4EJmyF1rhdcXxJLh6/CYmU82gUeTHig4zouv3F13/R7lwFPPAK7twRQeEYqlq5
	 6uRiwrg0wvXQrXMo267cjqxcVp5X6dZ2QTEwenFXsrjxwYZGFhZ0KC2wVKTw4V82AN
	 sjckUp4jWplfjvIS0kdUDmEuukUS8DJWCYPprJWjVHBj+EDTDhw/euJYwG2Hkv1Ogn
	 N4sg9AHUw0HL5Fy1ibTzckVRbBMnABEjAcOEeMlNY9n7KGU2GpM0WYF1tvHOHHiYmj
	 zrst2lJVzpnBTlNXNcOEj/qARiRd/RpgfcbVM136lWhgi1ALwr7kgfx007zPCgim5b
	 dHDO4Cx7Oq9Ig==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
 "Frank Ch. Eigler" <fche@redhat.com>, Francesco Nigro <fnigro@redhat.com>, 
 Aaron Merey <amerey@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <ZyACsIFUETsr7-09@x1>
References: <ZyACsIFUETsr7-09@x1>
Subject: Re: [PATCH 1/1 perf-tools-next] perf probe: Fix retrieval of
 source files from a debuginfod server
Message-Id: <173032384796.1221980.9416206490432022133.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 14:30:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 28 Oct 2024 18:31:28 -0300, Arnaldo Carvalho de Melo wrote:

> When perf is linked with libdebuginfod:
> 
>   root@number:~# ldd ~/bin/perf | grep debuginfod
> 	libdebuginfod.so.1 => /lib64/libdebuginfod.so.1 (0x00007ff5c3930000)
>   root@number:~# perf check feature debuginfod
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>   root@number:~#
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

