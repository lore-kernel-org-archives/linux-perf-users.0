Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736702A1AA;
	Tue, 16 Jul 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126460; cv=none; b=poFqVA48yIT6APljZWHP4B/xoDw9IfZA/iKNw4p+NzPiSEFNd7LjCUqyo5ygBh5hzhMxKh+CBa/KPROFRiMgblXqaYavru6pFf8u2wuE8f9XE7QyEUhqL0auLSWTPr7M97TUnOf8thhty/9i4l3UznvbAN997PFvnxGZwqW9DTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126460; c=relaxed/simple;
	bh=/SraORAtXARwc4Vs76eXKpRKSbnwaJT+4GP6EtjDP3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0IiHVcBpIHC8r9U1TdWaDsetN6aMAaXwpnbDvzryX8JvYIwUXzrXAqXWW2ESq59z6ugnpw2p41VG1miXtM1kS25PPvtXl5AqF+Hd5CLxym0QwuNBYBZC82F+zJzDC/AbeI3hvnlfsQ0cymqpBq0YTIRD456JVDNYm1sxW6drSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063D61063;
	Tue, 16 Jul 2024 03:41:23 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4AC63F762;
	Tue, 16 Jul 2024 03:40:55 -0700 (PDT)
Message-ID: <d2f1b470-fb81-4380-8957-aa56efabf58e@arm.com>
Date: Tue, 16 Jul 2024 11:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240715143342.52236-1-leo.yan@arm.com>
 <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1e5aa1e1-e5c4-49bb-a43b-a119710a000c@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <1e5aa1e1-e5c4-49bb-a43b-a119710a000c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/16/24 10:10, James Clark wrote:
>> On Mon, Jul 15, 2024 at 7:34 AM Leo Yan <leo.yan@arm.com> wrote:

[...]

>> I think this is objectively worse than just removing the file. It is
> 
> Objectively worse is a bit strong. There was some discussion on the
> previous version about the reasoning, but the point is to leave keywords
> so that someone re-writing the NDK docs in the future can find it and
> then the history will be preserved rather than putting it in a new file
> with a new name. Or even someone wondering why their build command
> doesn't work has at least something documented about it, even as a negative.

It is critical for the document not delivering any confusion. Keeping
the doc with a clear clarification, or deleting the useless doc, both
are much better than obsolete info.

> Of course this all depends on whether we decide the Android build
> _should_ be working or not which looks like is also being discussed here.

Yeah, I think the important thing is to get clang/LLVM cross build to
work. This is the prerequisites for using Android NDK.

Thanks,
Leo
