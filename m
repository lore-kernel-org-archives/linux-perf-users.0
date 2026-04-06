Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139772D0614;
	Mon,  6 Apr 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497776; cv=none; b=Kv1/Vs8RaUWlZMLVG4sI0Xoe5Gdik2rdsM5xlbr8uTEF+EzY/b+Ex09yoNhl0/pMRylIaanR1AUIBw6eP5mIRcbEobP2eDeiae4eKOMDZ7tiY0B2l/qUqJfLeRYFJHZcd0GkRmUYZ4hmiUaK43HomtaH4VHAwG8lbEG2suZFiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497776; c=relaxed/simple;
	bh=bZTG0YcuQg7g7BATQodBbFbF2LtucYPP1CGHanC0pac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7HQFGJYsC165gRgK85kSiNE0D7ls3nBFtKetdcQwyJHcfRb9YB7CJ6Vhq6iHZS0Tkc2Sq6oSrVWgBTeWSdX7o3xfvUf+BtpCZCMnClBiQxVLNI6GVSF1f9j8tGjkBhG1WVMtXrD0ANPbz7MEvPWNiWZZ7/EciH0dVT+QZI6CbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOq60OG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOq60OG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C04C4CEF7;
	Mon,  6 Apr 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497775;
	bh=bZTG0YcuQg7g7BATQodBbFbF2LtucYPP1CGHanC0pac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iOq60OG/Qheu/N/OfCW20+EMffvwe8AVmBuIZ91atvjbqpgTbJALZseaHGYWBawuP
	 qI3wC/3rXqU98ShFqsTwbTdNnNdDzh3OL/delriBcUms8KpodLZ+myz5Ycj6eUP8d4
	 fBTwxBcnBD+SdAVRy8b718aDWIP+uvvTVxbATrZpuon2AIgdS+hgBWivLnbVW+Z1sj
	 ymXCebaizmDgtATZSFi+boaDDrg8oDdrQMLu2dcrhWOnwd9AsaARPBQI8saJhGdXzY
	 Qk8VNS46KDzixulmnt60+tx6JNmrgu+/8p1pdOIZBcErhOw3PXwZnm5I3xUfCDGUsm
	 QAr81KE9Nv35g==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 bpf@vger.kernel.org, james.clark@linaro.org, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org, sun.jian.kdev@gmail.com
In-Reply-To: <20260404060552.1585709-1-irogers@google.com>
References: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
 <20260404060552.1585709-1-irogers@google.com>
Subject: Re: [PATCH v2] perf cgroup: Update metric leader in
 evlist__expand_cgroup
Message-Id: <177549777524.455793.15679188332866093795.b4-ty@kernel.org>
Date: Mon, 06 Apr 2026 10:49:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 03 Apr 2026 23:05:52 -0700, Ian Rogers wrote:
> When the evlist is expanded the metric leader wasn't being updated. As
> the original evsel is deleted this creates a use-after-free in
> stat-shadow's prepare_metric. This was detected running the "perf stat
> --bpf-counters --for-each-cgroup test" with sanitizers.
> 
> The change itself puts the copied evsel into the priv field (known
> unused because of evsel__clone use) and then in a second pass over the
> list updates the copied values using the priv pointer.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


