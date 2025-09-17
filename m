Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A11225A3D
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131539; cv=none; b=gq/lh8bdY0QxM594REJKy/IvOSbQ/7MR/FsfmF9s9OkPMKYZb8hcmiX+R12/oCE7FMdedIdJ3kfcDsbRE23BLBbaSRVkiKfMaRsJvret09hDUjXB7bU7PIlHbuscStEErIV4Gmm9EfFwRr91bWC0nZF45Fkwvyt9Llv6bVLJ140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131539; c=relaxed/simple;
	bh=g2/Cse7salc1tIUE/OJp9FayjCskQFXXIpcOQv0wqcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZv6JTVh8TzD61d6XY4WBW18UHDOoKzMmlRfEO01k/5+6Eo9m6ayRpQVwrdHauVqsWDCOv8UFhLGRKlnAx2vkARQuktreDwKfPGf7nUZ/3ZPWG4G5kVfGEd0GB5dK2QVkzjzurmjO7gDk4jKmaQ2osaKTJ1nc5vhBn/AUhtxMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FWgOARlf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FWgOARlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Rx5V
	0/lZD/IdbtCuUfwjiSEO0Grpo0JaThAgFi8Wh8s=; b=FWgOARlfcC5bBkEhH7jG
	ITFPFlwr1VAfDuV0hIVqbDeNRxa2v7Ycn5BBKxibO0KMk2WxPeWb494SJo3SZ4QE
	RFClSWn1PObw0nS9NEb3t1IMYTqChz5GwKXqsFSu9j0TT3VWAwE6MN3au5m6mGpS
	JD/p/ucC6a7lTlJguzmIG+T8RyBoUsUmd+Cy2Cg3AZdC4PTagMr5mrvyPECtqOUh
	rSgilWdz3j4OR/4LUArMds+Rffk4gY60pYA2iLgddKm6DKEjeKNKUM0HjLkxrPzc
	/OPXKoqjG0tih5tcmDLmR3lqI7P4yCJGfxt6ZBz/cgerHqnfaKm8oige/Ejgtbyi
	sQ==
Received: (qmail 3221545 invoked from network); 17 Sep 2025 19:52:03 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2025 19:52:03 +0200
X-UD-Smtp-Session: l3s3148p1@Zdbn5AI/itEujnvK
Date: Wed, 17 Sep 2025 19:52:02 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"Liang,  Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 5/6] arm64: dts: renesas: Add R8A78000 X5H DTs
Message-ID: <aMr1QjI8vfrP_fwD@shikoro>
References: <87tt13i0lh.wl-kuninori.morimoto.gx@renesas.com>
 <87ms6vi0js.wl-kuninori.morimoto.gx@renesas.com>
 <86v7li1xs4.wl-maz@kernel.org>
 <87h5x1afgr.wl-kuninori.morimoto.gx@renesas.com>
 <86qzw51pmw.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86qzw51pmw.wl-maz@kernel.org>


> > And, the datasheet is very complex, I don't think people can find it by
> > himself without any hint.
> 
> I guess we're just a bunch of inexperienced idiots unable to read a
> TRM.

Please don't feel offended. Morimoto-san really has a point here. The
datasheet available for us is currently in a very rough format with
*lots* of attached documents with hard to grasp naming. I am dealing
with R-Car datasheets for 10+ years now, and I do have a hard time
finding the information I want with this one.

That being said, I agree to the point that it is not very helpful to
reference such documentation upstream.

