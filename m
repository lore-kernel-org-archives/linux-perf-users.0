Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A33A5E88
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621064; cv=none; b=Qn62bbZFkLZaav22PvFJWQ7w2zG1kxZfIsatsNg/2dUOYUt5VBMy15F1lJjNkjLjn3Awcky3O/Lpt8arzUMEDVH8YPwH+zOpnQpuvztGZD3qDbXk4VNuqK3lYulmPC9PU4GjNNNLJ8uSnulRSH9xv1f6FgpNsbtkQheqGn3Esms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621064; c=relaxed/simple;
	bh=7xHYTN8vEq3eQBZDedfY7A54wczhUz+xR6ttxUFtPyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcsL3daG3uLwJYPXGGErtnG/KCAQooXzKAQ1febCoajNfdMn2CXGN6yCtd69+/X9KzUx9I4JowehANg8dy7ASkYYpK8LbekfLhFd+lwZ9OKzNZHJJPXZ/m5oFia7dmN/8nf2MsFGAatFGVVas5PQKu+n27v8wCzuU5C4L37CtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE3rf2jA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE3rf2jA"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9359c0ec47so723528366b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 02:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772621059; x=1773225859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xHYTN8vEq3eQBZDedfY7A54wczhUz+xR6ttxUFtPyk=;
        b=PE3rf2jA+hI/dYht8j/cUAUe7BLdbzMkmDWWXGVkl4PBdHBYIE/OJXekfzgfhB9jzT
         RIhUijwpUGoe0ydRKAxweOvx0FzTBBw1vRryC2UtTvVyAjvO+EagkTAKXYrKSkmVlDfF
         8/XzG1ikxao32L6kbBWLyi6XLfvzxu+kPpsLhPujuSFrdInPjfB7Q7AC7E9h4CZfoEmi
         4K+ohQvijZnYnI2jX7VUpMIBBZbGexQKwD6rIKMNX9T8SjeaZ7ZfYf/0eJAbwlZUiD+Z
         pLeSW1bCayNvDSb9QZJINvFkddfDbMALSpZXvjgtXauCx2mAWk+eapjstbs8DU2NsdDP
         pc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621059; x=1773225859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xHYTN8vEq3eQBZDedfY7A54wczhUz+xR6ttxUFtPyk=;
        b=nbCw7eQbrN2TJFAZXBlbdrbUTLILYvVRWBigeO+qzyVFrwVSUjEmL7iFxdZq4Be3hL
         5wxM1p/V6B7y7GE2C0eVOsBumXae2vB277PR5o0sn+pY+4deds78lw8IrErixf35zldr
         TLooNEY+rBESFrA/Gdcuy9rfgR5AUr0TCy5R3oj+72tQkhIofrgjmHbgqEP1PcDMr2ON
         PDaBUhuing+alYbXYyADpYuz7/M5Ud6MRFVjBBmsSJHaqQXnTNn6GCXDBjy5kIsk5J8U
         C3Vb7vEg36G7N78M3Jc/7laX8vva/uj8NzI9T7zD+QAKelI2evIbqjmH4EVWnSWrAUh+
         /Egg==
X-Forwarded-Encrypted: i=1; AJvYcCXb8GXiIYX5rj3yykAQkmzwTiSYvVPIl1uAiTy2YPHzC+DajVV+Rm1AlWT4tTD3BR4qGM1UNG/58z/zfw+u2biP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cxdc799wSlm4OYyY1mGMr5WAMTEQp+O/VgDvhS2aDeW5LAM1
	hKR+ChYPIjen3lML+9k9eMPg/D89Pk+8ue8MzObxjwjrNHK2JZMMgTzR
X-Gm-Gg: ATEYQzxaHCJTcHk/C3JJk0/WQev133aVz/q2hJ91M1SIFrgBx2QC2QH7Qne7INWk2bt
	MPG93xAhW3tCTWJpfzP2oVvjskQAnWj5rk5+aQP+KK+DS+aIQSSXUB4uYLGYiY241koQsSFfcOT
	wfoZqwz9+18ti2GrafXo5O95ddEK3d55PHvl2ncEoo6lV0mGXNsPF9sIdJkEAhUx/m9Yy6gH9cm
	gk6j4uhdyB1JvhVAlXYUjfR+oWpKP0z+CxrfIxKyNZQAZSzjPXpMeZIFzoIr/TYdrknPLr9TOlb
	TXSTQoHtvpkr5FifJ/cD7SQ1p+wk6fTpNxDJT8Jimbq39xkBuHuOozTWGjX5KoAI/OgVPyr7QC+
	tSBZPD4yn/eQN21bAMmzpyaOZd1UEJfmq5/turQZuOAV0aZi6SC867hOSsVWyKidHLjz9Yh2eSj
	EtHl0WIEinyyJ+ZOnJS6B+WSONgyKxsQVirr08+qItQXNhheLzu6ubb6R6CQ==
X-Received: by 2002:a17:907:930d:b0:b8f:a0e6:b261 with SMTP id a640c23a62f3a-b93f13db7c7mr73070366b.39.1772621059193;
        Wed, 04 Mar 2026 02:44:19 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb ([2a00:20:635b:6c1d:750c:5b7b:26c6:b5b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aead96bsm725884966b.51.2026.03.04.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:44:18 -0800 (PST)
Date: Wed, 4 Mar 2026 11:44:16 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@kernel.org, 
	acme@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, lossin@kernel.org, namhyung@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302235821.588686-1-irogers@google.com>

> On Mon, Mar 02, 2026 at 03:58:21PM -0800, Ian Rogers wrote:
> The typedef creates an issue where the struct or the typedef may
> appear in the output and cause the "perf data type profiling tests" to
> fail. Let's remove the typedef to keep the test passing.

Yes, makes sense to me, thanks. As mentioned in the previous message, it
sounds fishy to me that perf record and perf mem record capture
different data type -- I'll try to get to the bottom of it (I was sort
of hoping to finish the cross compilation topic first, but since it's
not moving that fast, why not do some debugging here).

Reviewed-by: Dmitrii Dolgov <9erthalion6@gmail.com>
