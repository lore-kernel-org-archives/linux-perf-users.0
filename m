Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60118EBF;
	Wed, 29 May 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990783; cv=none; b=fAOIn/Y29J4E4QRCYx8Q3neyl0lxMDYDE41h6gRc1r7KpclnkoQz0EU1VF22hzDJniFztN2OS3d3kdDjB0PqOGFYwSJDG5ZXzQbJ+3X4wflfKQVR4mh0n8zNmM88z6wVQy7NI56ebzywzxIufeHLRZQIfOK80N+0S4tXRiiVgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990783; c=relaxed/simple;
	bh=HG1qwdrauwGJMJ/oA0LWphOoXDVfdosUPwm+vgiq+oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgmpOItcPbwH53J2jeVEbhtTiSJ506SUATpg/1ujSrw4z47PiYlO35mlu656M5u7E52L3oj9fI6O3R1rW/8Tx8oF9URT7uKm+Go60DJG5aasX+wVwDU4GOzboYkwW3nuZAOJ25ZMbxG4LVJIcMe+7s4Giqy7ay3eZeqff7n1HY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct1xZNh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct1xZNh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C5C116B1;
	Wed, 29 May 2024 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716990782;
	bh=HG1qwdrauwGJMJ/oA0LWphOoXDVfdosUPwm+vgiq+oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ct1xZNh+L9P9j7w4jiyfk5UCVDwcUslSnN81JH8uYFUyS1G5z1lzkB4NuCPMvM05r
	 +pB24dhrSIlzYxtbODm3wzYzcV5gFdm0dB00VewMcnvNvLazFwoGe0vdnzV9JBdWRm
	 LN/hhaIGYHqV/ZlkOh8nb5bBbLwZQhKmghBkgQBT3Bdb5AJPfAJPzStKk/nKSyYtzE
	 rcKgUDiesy9BNn/6A73VntcASRDUET8wkZoD8HLzCQImkd2fSskl3ZAzTN/qlZIKJ7
	 FdupN2eVDJ3FfXgUJ8koE5mathxCOCM3AIGx20WmSoUQVwArMSnYTF8zdRgF0VmFPf
	 5wJ93/mBBLI/g==
Date: Wed, 29 May 2024 10:52:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Steinar H. Gunderson" <sesse@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
Message-ID: <ZlczO4D8J1lgWBZj@x1>
References: <20240526182212.544525-1-sesse@google.com>
 <CAM9d7chY7CzMx9sSYeagDK81PsE=soGmn4AUxXAE7rHp=jmx3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chY7CzMx9sSYeagDK81PsE=soGmn4AUxXAE7rHp=jmx3Q@mail.gmail.com>

On Tue, May 28, 2024 at 08:56:47PM -0700, Namhyung Kim wrote:
> On Sun, May 26, 2024 at 11:22 AM Steinar H. Gunderson <sesse@google.com> wrote:
> > +#elif defined(HAVE_LIBBFD_SUPPORT)
 
> Hmm.. it's unfortunate that we have only one addr2line
> implementation at a time.  Maybe we can do the same thing
> like in annotate with objdump so that it can fallback to another
> method when failing.  But it'd require more changes beyond
> this work and I'm not sure if it's really worth it.

Right, I think we shouldn't delay processing these patches because of
that, we can do it as follow up patches, both for fallbacks in case we
can detect problems like we did with capstone -> objdump disasm and also
to be able to compare outputs in 'perf test' shell scripts, discounting
known/expected minor differences.

- Arnaldo
