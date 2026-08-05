Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539013CC7EC;
	Wed,  5 Aug 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954498; cv=none; b=l1jZFyTysOLuZyJDQLw073u4rDz3S0GHcvVJx21p5vuxnj7X2gz5bh+clJXfOzhO9LyOcIzLFgxc66W77yU+9lDvnqRmMsXXKH5wW6v5wa3C+84FkB6FQcxgbwFBRB0OHVVLOba4DUCrBz4tBEsEOQuygZ2NmKfMBzbqTK9O/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954498; c=relaxed/simple;
	bh=hWFf160WQddUi98tC6T+nSSD97r0Rf1oRWJLTsJ/fr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MzNUqbACMGEzrGNTEHRX5dNSrAL5eTjMl3ld1h72+CBfMx4SV1tNuVLoQpn+ZST7qD6QSNLmgfF/A6EPrM9i6F3XXpOm+p08dr9Z8e36hv56f+Bg+qhrU9pA/nE4SkGRKQXYRwSTXfeKX8YpO96etSW9V6fPisavAosbckLgxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuL+x2hP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuL+x2hP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DAA1F00A3D;
	Wed,  5 Aug 2026 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785954497;
	bh=SI76pAbnffsV1kNwyfq0vxq23oNmfQLhHW9VJBuGxWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PuL+x2hPODHo9E6Iq+X81VDczl3HIrLJITiGNobc7SwL4SyPmEKsZCzOfaIvSS4Ma
	 A8Kae2IAA2O9UsDPzjCqcz6Hoy2VIpvXSl4Z3rIgeaDk/0rGOpTXUY410UYa3mfm+9
	 zGSkJADvibKOgFsCqvAY9KHy+qA2BNQ6evqX2tObUq1xrjfGdefVy7B0G8iAtcDz39
	 OgVrB7/2uBGbxA4P9cFmCnzEC8m1OdeTbZKrHnNVCJDxtZw1L80cMvgy9AZAv5anXX
	 QPub2Do3b3lf0DjqG8nfvtnVB2H1vz5bcQjOq0Y1uB+BI7YDGwPz3t03Qb+WHiNe/g
	 W+T7pVyJPh6DQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, 
 chjohnst@mail.com, sean@ashe.io, steve@abita.co, rishil1999@outlook.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803124845.213165-1-atomlin@atomlin.com>
References: <20260803124845.213165-1-atomlin@atomlin.com>
Subject: Re: [PATCH v2] perf trace: Format fields with hex specifiers in
 print_fmt as hexadecimal
Message-Id: <178595449650.914389.87119431734742911.b4-ty@kernel.org>
Date: Wed, 05 Aug 2026 11:28:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 03 Aug 2026 08:48:45 -0400, Aaron Tomlin wrote:
> Currently, when a probe event is added using perf probe --add with a
> hexadecimal type cast (e.g., var:x64 and var:x32), the kernel traceprobe
> subsystem sets the field type to "u64" in the event's format file, yet
> generates a print format specifier of "var=0x%Lx" or "0x%x".
> 
> By default, perf trace uses its internal beautifiers which only inspect
> field->type and field->flags. Because traceprobe events declare
> primitive integer field types ("u64") without a C pointer asterisk
> (i.e., "*"), perf trace defaults to printing the field's value as a
> decimal unsigned long ("%ld"), ignoring the hexadecimal intent.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


