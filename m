Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B76381B04;
	Wed,  4 Mar 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660934; cv=none; b=ci3q3+xaSaHiAXMbzGjDU8y8uUVBF3Vecmluig1zh2wJe53ckZ2X0hOo/I6yW0w1TVvlC74gN8TN+e0iFF6xqOhbVcGKy63OlZwttQ+oCP8Kby2HwrhKAxFVC61Yl1uHmv/RYNIbRuLqoNlhEiY4kRsw1o+FUA3j3oDMD+mYn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660934; c=relaxed/simple;
	bh=w7d3HYxOn+xhxuEK9OxeTGVbMlKaT/ikC0ZJ5c7XL+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WEWQQoL7JpbIolOObuSsMBEuDPHSDek3FvK+uffZTfp8bxCPyJOLFSSc/28qNrRIKlQ16ej8uW3Vepn7wBo1OZV6AQEb9gGO391JDc5eY/lvGx4jogQjbXo97Uc7UWDdjJeBXOwmoMizuOtbVzwUKZdVV8ljq9nps5rEnEEf3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZMSH6H5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZMSH6H5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8E0C19425;
	Wed,  4 Mar 2026 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772660934;
	bh=w7d3HYxOn+xhxuEK9OxeTGVbMlKaT/ikC0ZJ5c7XL+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eZMSH6H5gaf8L8g4ujE4wIyhFbL2UniEJ71Yvz1CsDSYW1+dVONA3+beOKEEUFxtU
	 r0WzCLjMWlleQR4WNzrZ83e/6AMkvnLjPOS1JGw4X5vNkD33TaXIbi57+wTBUcYgHK
	 3uLuy8poFhcyGi15ZxdFMUtpTYKlvsVP4v6/m+h0DPPfPEzjQhR9gSDCdraJGr8tjF
	 7PGK1N/HEpf6gjm4M1ospP1YPE5TDpMomYZzmXR2ycW1IMxlhiXMSiiArw+1juBIN/
	 DZovQONVV7K2lVG3R03VYwClgSdbdDywX87Lhe69om7liAphdnhLKMO52yCrsNGNf3
	 PgfVeEBMn7JCQ==
From: Namhyung Kim <namhyung@kernel.org>
To: 9erthalion6@gmail.com, Ian Rogers <irogers@google.com>
Cc: a.hindborg@kernel.org, acme@kernel.org, aliceryhl@google.com, 
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, 
 gary@garyguo.net, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
 Miguel Ojeda <ojeda@kernel.org>
In-Reply-To: <20260302235821.588686-1-irogers@google.com>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-Id: <177266093391.3626597.10862709116758155175.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 13:48:53 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 02 Mar 2026 15:58:21 -0800, Ian Rogers wrote:
> The typedef creates an issue where the struct or the typedef may
> appear in the output and cause the "perf data type profiling tests" to
> fail. Let's remove the typedef to keep the test passing.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


