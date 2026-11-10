Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279146;
	b=gegEc80t6OVT5kKLlI5kpJl0DIKDJbKWq7knFN2RJqMxiqYP+A9aOLsHxhssdGubbHwv
	 SXsIMmGUyDoqM8QIO9HgxVWsl7HnOpC7/xTy6fN4MG1IpMq55JF5a60uVVhXeyP192A2/
	 4nqJ7hiE7T6lo17IDjiwKSdIGXyU1mza03LzsmNK6cqRYQn8+QA7k4Q0o56tTP0uY0Cdf
	 B+Llg57BS5lvmuD0nl/kiEo8HLSWv0manCLKNRsFxpC5PlIjuk0SOcrRnoUo+GpdmzEPQ
	 8/HPg4pL7fkhasQ/ICUGBiuOmW7UX4FOiaBjG56VCOvM/vhXYJrzALliIN12JWDH+tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279146;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=nVLuWoo1y6ND0a9aTD0T7hC5NidaBGXYwbt6YdA3oj4=;
	b=WLKhPwcIlpb6HVA/QKDUq/LVqM+2vS1NgzKG+R4MEDuoy6NreJhxNU1HEOjFXAejIZEa
	 t4ZatwdifS7K7GUeNRgWNqTncBFb38Ac6EMcEjaEUl+sHCUKjyopZSjUmIQe7pC7YVD2H
	 sI2JSP7Q6z4kHywjbJDCJsUckq2IQAgebXzfptOQcEWbyv+Zd5Em4LHf0+Vi7ZMeYGJBD
	 fcamMQ2JuZq5OkmZD2tN35Wc2ZEF6NgzMA87RZ5rSkfAmtCyEzzSrhabQ3f8AXxttCu37
	 9VZzYOOtM4Bm644vhUG+EJzbeQQAfSTXumXFP7/joH02CqqjGtd0KxBeBVN3bXefr8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJsTVEXC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50D60A261B;
	Tue, 10 Nov 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJsTVEXC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC8A1F008BD;
	Tue, 10 Nov 2026 02:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279146;
	bh=nVLuWoo1y6ND0a9aTD0T7hC5NidaBGXYwbt6YdA3oj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FJsTVEXCtfu4LEG+ppmzxVMLMGJT4p0KqLf8loa8ZxHp7vifJbY05Lsi4mNbtquj1
	 dkQvMujeewqf0l6LTo4kX4gCebrSHKT5F5CheNlhm9uSqsmxd8fuXLHqTF1NN3ZWeA
	 aQhpx3HYORmzFR8XcZ+GGJqSUOhHxmPY4/hdb4d6DOkrAo/7R/kKNdE4eRmkbcDeoG
	 lcbiWSI2Cd3bm5HvmDHQISHMLsa+hATM9/ETAYgrIz1WWz6IDuxwOfC30G40ScWHnd
	 njwPZBzoKdxDo8VOUuSq/FzrMAoEgfd9ikBhy00DUJ/zXPMs8qhuLFKc+RLWCoDjfl
	 PYuwxUXLJzhlg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
References: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf hist: Fix branch_info index for sample weight
Message-Id: <179427914553.13444.2646955447454960251.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:25 -0800
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
X-Mailer: b4 0.14.3

On Wed, 04 Nov 2026 17:02:28 +0800, Gu Bin wrote:

> iter_add_next_branch_entry() is called once per branch and uses &bi[i]
> for the hist entry, but reads the weight from bi->flags.cycles (i.e.
> bi[0]) for every branch, so every entry is weighted with the first
> branch's cycle count. This is incorrect when the branch stack contains
> more than one entry with different cycle counts, as the weight of each
> hist entry fails to reflect the cycles of its own branch.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

