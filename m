Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0069D2B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043513; cv=none; b=teBdu4pY4WqWU7xPulyQtMz5UnrFsr4PI6v8YYo6DnJeuriQ5awQS/90xwtGW/Li9jlzOktmCaeCTFkOV6vpU9eXa2EDawdxUg9NbNbGFlDp36/19mwqCl/5ypZINpSJOUWtcZI6EWBM1aRwPXSvzyy9lxa0yQo0H61oOFWDhdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043513; c=relaxed/simple;
	bh=x/ILfJxrfQ0oxJkAhl/H43QJHfOl/lE+iSG97Ooi0O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN/+ioU+VMNTWD8qChkzqUlqcKScydZtq3FnUpocpIDa8l6j16yH5tnMefcQzziackTeS2O/lXHq2pGpTdcE71h4zoufQAcDatSOnT66VayjzlfoQubVHZHiJkIBxsxL3VJ371/Nt35csni7UYpLWo4smjfduBFcSYkmqBFILVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRVwWMLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRVwWMLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598C9C4CEC6;
	Wed, 16 Oct 2024 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729043512;
	bh=x/ILfJxrfQ0oxJkAhl/H43QJHfOl/lE+iSG97Ooi0O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRVwWMLNqxRQrVqJ/EPxtdBB7jpQXDYAJJfACwRPWgtqBZ9XoJZbVO/rLjl4GYXhu
	 GgojBVHtRgJHVYXkd8mQHsJYP9eNzPBjSQ1CiZHbDFXQCJmtq7uRHV8b9aE38Qvj91
	 PTjot1cw7xNI2f/VzMPoVjCpagHWSQcP8zQLwqO9xZ/XNyijEDbpz0+R8DS7G9lsP3
	 8qPcolN83OzwqglDIamqKoKvzu63Nbw5tH9tNxqw3emeLHN78dnPzvrT6CQejgXH+T
	 DtKkJ/uffubgmNYrMiSAqnCyoP6BJ7DvcuCmDk2C8hah612fk/iD3+ch3zVMrqd4ca
	 IidUV72ha7sbQ==
Date: Tue, 15 Oct 2024 18:51:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, Yunseong Kim <yskelg@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <Zw8cN9daNBvCJd3u@google.com>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015-warping-condor-of-storm-afa06f@meerkat>

Hello Konstantin,

On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
> > > Yunseong created:
> > > https://perfwiki.github.io/main/
> > > Perhaps the solution here is to make perf.wiki.kernel.org a redirect
> > > to https://perfwiki.github.io/main/
> 
> To speed things along, and since the old perf wiki was near-unusable anyway,
> I went ahead and set the redirects from perf.wiki.kernel.org to
> perfwiki.github.io.
> 
> Please feel free to follow up if we need to revisit this, but things look good
> to me with this change.

Thanks for your work, it looks good to me too.

Namhyung

