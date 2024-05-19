Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBB6E605
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716152300; cv=none; b=JoA9rKuIj9OnBZdM9GPEl/Z5hxfwULyiyc1UQbLx6GtkHzJzhcVQ43MJYmtdvAbV5zUeNAYsc237t7VPwYdwBTcJsRveWBa1t26/43JbUidsPfiYXL6pVCA2lySaHmERwYdVlnS2zK5AhKoR55A2oC8fhMDqb82PjodbC8T2GPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716152300; c=relaxed/simple;
	bh=5yRNOhU5A7657bzYs1PfC58Wr0uPu28IMtEfJJ3cC4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owbx5pq3AMOdWiuq3ZtF8BZN2Mg4OFYqmhMqxesW+6NgySuWjsL7v/bPFDaiVn6f012x2lLz/xUJ6hFn0V9tKafw0eGV5IbJa2653e/ZPIgyWIMzzTSmQ+is6ffxzgh9/mV2Q9Fet4XsghzGHCCFDOUhNp/DwSEw9sx2MP99Q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2X2hqGL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2X2hqGL"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ffff16400so5911618e87.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716152297; x=1716757097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yRNOhU5A7657bzYs1PfC58Wr0uPu28IMtEfJJ3cC4I=;
        b=J2X2hqGL5SP8DofWLezjG+MVeYq/drtjASTXTJQlONEoOhZqJJQFx75YG/18j889TN
         /TetvukejHprk49b9Lzt94n8y1LC6MdMiVp7XC71v41TRdg/AclbC74hFf8EfJE2ZZ9h
         kgJpcIL/FcgxO5qjSgNar94k5dTAmvDtkYfLkXJWCt7ZVjnfYx/Zn6geeNrtGag2lNfw
         2//EFDIWYJNUCa8gO7+KB1YdAUocZ/ooXS8PXEj9Y1mmEwltBoRvB18i+njDsH4DI/sO
         hFnKlpkdm/MS0GZptNixttiQeBBzm1PfBY4gvwe2npHkCK2kUIBBZ7Yn3O1i/0HNVprh
         lM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716152297; x=1716757097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yRNOhU5A7657bzYs1PfC58Wr0uPu28IMtEfJJ3cC4I=;
        b=PsdnkfpywBmeatn6rSWv/dsgUBlb12VxCX5gs43MBCAfZUptMTXFHRvA2QvtD6ZTvw
         /1GXoquxM2Bdq81eNLXdTvs+JKtmuchkUubruVnr61AOsLT9PRntBr1ow7fqxi+++L+c
         2lbELO1FmoaSnhKhYgIxWO7QaqUXKiwWXy89hIg3qT1WXhknGKeKL0kh3p/ZVvFJydXg
         gn0+DZn77BZiS58dNfYmRNK8a2kRxRvJRHIhazeisCloBrWGzmtZnSArcvzFKb2giJNt
         ttVJOU28Z4yv5BZsUpyBhafSPgiMfYlzLIel2j28bcQ2/oGQ5fA57mrG2wyhzt9qFcPe
         XgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiWZIC5nXU+TUui1oPQbKEP7qJJWpThrUPRbbiKTttJwCKXtBOVyUhiF0bGIqMMG5yoMVHHR4i85hAI40ryC2PTuuANb9viPzdBqoJC8HMjw==
X-Gm-Message-State: AOJu0YzV4aibv5/49UB5h4OJoRrC+FhhjN+ms55/YvTJt+LzASfmN3OS
	8R3+Ne4Tqi4dWDTeIVTmC7xYJHGTSGxosPbFe0UqEV7SZVoN2ahBOQeot1LZgw==
X-Google-Smtp-Source: AGHT+IG43adAH5oGa2Y5aasAJK7+4mqBNIlRGabXhfce6DxGG1+Qzgoq/DRDpH65dHqkN/tDUGVokg==
X-Received: by 2002:a05:6512:149:b0:51d:4c8a:bbdb with SMTP id 2adb3069b0e04-5220fc7d133mr21143293e87.3.1716152296909;
        Sun, 19 May 2024 13:58:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:9677:a1ea:4905:181b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d7ca0sm4059536e87.304.2024.05.19.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 13:58:16 -0700 (PDT)
Date: Sun, 19 May 2024 22:58:12 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
Message-ID: <Zkpn5Dtva31rjsEg@google.com>
References: <20240518165315.3963142-1-sesse@google.com>
 <ZkjdQqN1dPsZDDRA@google.com>
 <CAP-5=fXPFtS-aufdZE1_haEo6EpYYDw9JhG_4EjHi2AAzzf5RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXPFtS-aufdZE1_haEo6EpYYDw9JhG_4EjHi2AAzzf5RA@mail.gmail.com>

On Sun, May 19, 2024 at 08:50:37AM -0700, Ian Rogers wrote:
>> I accidentally sent out an ancient patch anew; sorry, please ignore.
> Presumably v1 should be reviewed?

v3 was merged into binutils two years ago. :-)

/* Steinar */
