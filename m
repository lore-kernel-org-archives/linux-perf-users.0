Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424176;
	b=Le+N8h4DXpXvd/bycEakw7qGgIyQIXYIVSSs4xHpdWiGEShdFhBHho1EOhoHgTI1ynKB
	 eb4ea+RUccojBEiOAGKaIT8lkcZkBcul1V4B2DhC1scZ3usivoDYMtcfw9296q65wZvVO
	 vWrr+Zyl/92VKUY5p5qG5hiyldA1qF+c73A+XdYFwXh8BgB8JD71MlsAAbMZDsXgv5JKu
	 8YmSDCyKvCU4GwBD2NohvxUgwPcy2mqr30Fx6Y8dPioqNmeNyg+mm8WDmJPYT/QgZ1djt
	 2IsSVWB4d3YEdo+GPjW5HlzU8YO5G0cST2mwhqUyDrj0N8mp21X3yKDYtKfovBm+/TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424176;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=n8g69Ffy8X8/MidEKWQhACh6qmyitgBHvkPD7FRYFPs=;
	b=WumfFkS/5GKLmZ0fXYluv8O5WiD946b+6l7JwpOinrCdg/RdswI7oIJNaRpG43EhbQ4r
	 z/QxiS/40eHihJxOPzyQdhXWsosYRq91Ezn+QzsLZ74bdVjdAfl16QSHEuZKErHh628ZO
	 LyPRelp/mD4wNEr9ARBzielln5+ZQmzjWdElefJEJbgxW7NsbHZMNuFugYJsluLNhaaIF
	 7MorxRbtmAKajISb6TrGAkm7ZNdZdU8jHAxoAT3ZBQGK32mvYuA1IJIERlXJTGs9ZIQGy
	 NGNvJTU4LFaje5ZyhjjeCbb0VFDqr6Zoqirfrs5LFzwkhrbwAvZDIIffUUUN5pSNp8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBRw9e2T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299D60A2604;
	Wed, 11 Nov 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBRw9e2T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15021F00ACC;
	Wed, 11 Nov 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424176;
	bh=n8g69Ffy8X8/MidEKWQhACh6qmyitgBHvkPD7FRYFPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aBRw9e2TqfUocSssJ6RZBOTqXpmgachx3SCxgtoXnTNLsA7YxaJKaQmAYnNzUTbyn
	 7dytq2/s9GEEWbgqIiGd8Zn5BsHb5Wd4n/4scnqXTmmxVPZmnoq+zEiSyfXQjQrOdb
	 6YrWdg0gVXJyl2mBqnpcW0hHodlrtNGhAjAbhFXRmmGLbo7px+VjZszKLSMMhZaRlO
	 TGyRtDKB+C5Al+MUagVIClaod10D971df2L0HHZdFcCGHXr/U6mVzkklW1JN0293Dh
	 2Ecr5pPXG75PSSiiTem+vRDpUOYUlNDjUzNZsaFgqASRyl4/ARCOA3Dx2bvZboV92s
	 Q0pZESNlIA6lA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, 
 James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
In-Reply-To: <20261107051730.1880691-1-takano32@gmail.com>
References: <20261107051730.1880691-1-takano32@gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Fix
 typos
Message-Id: <179442417564.676192.15713798103748970108.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:35 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 07 Nov 2026 05:17:30 +0000, TAKANO Mitsuhiro wrote:
> Three distinct words are misspelled in eight description fields in the
> AmpereOne and AmpereOneX PMU tables: "Preditable" in BPU_BTB_UPDATE
> (AmpereOneX only), "satisified" in LD_FROM_ST_FWD, and "misprediciton"
> in the branch_mispredict metric.  jevents.py copies the strings into the
> generated tables, so perf list prints them and a grep for the correct
> spelling misses the entries.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


