Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3726352C42
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804176; cv=none; b=rXLOgzrT1FZA1cyW3UfQRUneuEH/9UbhlFMzHgfOtkMU7iv+zYIUP7GHzL3UGzQ2RhiKo6UJAq7efTD3P+F2vy/jixwSws3+nseNdeoFJI7/+Mt24ibYs/dG/Ljx0ZZPa8nO0vtmic3dpcpXFpyqBicg9oQnswYRPY3dMFGdMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804176; c=relaxed/simple;
	bh=19pFRZJDAkAdZlHJ+PLqYecDjGrwEcs1K3FITUBgTtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ0bi2aVHV5I5xuc8GMuebx33rKMHEcBpj5ewREL7pIWxo+RQqYpUjJNDjITUtnh5mB2A0PquyXbse8hjt6yQk34IhTTRfo1XNdbH6Hex0Vc/QlV4DpGPG9sePjNWSnKMn1KrUQkOpV+HLkjdEYGQpnz/lCeDuIDDFiWXjGtKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFeb2bLS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFeb2bLS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b885e8c679bso695468566b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770804173; x=1771408973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19pFRZJDAkAdZlHJ+PLqYecDjGrwEcs1K3FITUBgTtM=;
        b=dFeb2bLSe2JI5EFEEQzi9eJct036xLLJTkX/P+h1gzUdWUOvN9onf3wIE661da3+KW
         IIfuV9VtCiQlJT5lDJh3+0g9syHtwQnTLFng9yBx7MxPExZbQsZuNxrL1eVTnVjMt+Y7
         OYJVyxlQHuWtiOhCkGO+YYAdK7YhaxEpxALnQ85nEoHqU8iKxseLaFf8WDSk2dWkhOzt
         1qe1W2yrijF5mul80jCYA3nBHWCPo+eirC/CxSLzjwb9P8lOakEigsKsaVkFD7g4WHba
         vCNts6AFo8H51v6XejwLlfvWDrCJWlB4l+obJf9qJtKbq9ywwk+H3tHyXLWSZ7yk1Lg0
         /LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770804173; x=1771408973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19pFRZJDAkAdZlHJ+PLqYecDjGrwEcs1K3FITUBgTtM=;
        b=nzjz1NwIFPUUMPUOobOS9iIFj0jqNUj/0kjjaAP8o5oVLeu3nq2EFvYHWMAPUCQ8jW
         YPa0uar4m/MyQ4f33o5REZjw8DkG7INX7ONcjy6Djtk7ULTc0EKe4jAvRTApTHO7bL/S
         FxyYVTviB8QiE0baZTApfQMztcfXfMruA7MLvIQ0JlFkhqfymlUWcg9XiMjuCm7Bc6uf
         SShGNwkNDI2pAS1pYre+cnc/XYmfj72tYvZmaTHVsYogg6V89xs1BO3Opsfa0paO6uZE
         QhfX9e52nNvZsTDibTbrM7RbIfmhuAUk1aYPNSrGaKHc/mqnOQZCBsOLU0syov883mOX
         uSTw==
X-Gm-Message-State: AOJu0YxJ9i95qYVlCMK/vv8+VdIcDEwCUGcntHtHREm93poBbgJxd+ge
	QlKha31Mr4ULRmHU7oWPpjiQtZyCbF3wfiW2OY5obICZH6TEAnZbnFwP
X-Gm-Gg: AZuq6aIxqr9fSxHcZePxg5WeYmbUPNyZ71T5BrGxBBSUJp8e/F2HjAmZZ1hNw4JRcU0
	dXB+daJggwB/22sH4yjbketa7g/dlRJu7R/ZsRdYWMOXXrzjp2bYr3c/JBVvtTTOABspSzYtvTg
	3qu2eXrd3bglEky6pQGcGcluOyniI+54z+BTmPOW8EWoTupwtOc0mKXGvMGReAAy4epiCtipyyK
	cIkNeIbHe5d5yxpSIWo+i0Add9hoaHTo1psQxlhO35IMkBH6rPbCUMUl6IIFZOIjJYHqx5kqotj
	V8b5n/jZfKLozph1v0dbxO5wX1CMEThoKe3Ejbz9MnY9V3ofuTR3KkmMa64pWIguXjJPk7uKMIW
	ZAYUembVjBu3H3JapozaQ79VLY6IzgYHmeiJih7z+7+WndPhg//KCPCc5CtxGaSRCTEZErj1/cz
	5qi0TfzzpGDSd5EBebVsNYLqZ2qB/iHmpVpE62oeKO9RzO7ZkkeYVkAE+ygDQoDyrAexvWEZ8yU
	nwa/aDHwsFw8WO4RisQsJebPNbH3bJHakSv
X-Received: by 2002:a17:907:3d46:b0:b87:4f80:f4ca with SMTP id a640c23a62f3a-b8f6aec59d6mr127417166b.56.1770804172875;
        Wed, 11 Feb 2026 02:02:52 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e9a6c18sm45155766b.19.2026.02.11.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 02:02:51 -0800 (PST)
Date: Wed, 11 Feb 2026 11:02:49 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH v2 2/4] perf test workload: Add code_with_type test
 workload
Message-ID: <z5glnn5goh562dgbjub2u4uo6wjs777fqzyxek5mrgzf53qom2@vtj4wmgoxaap>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
 <20260208122227.3524-3-9erthalion6@gmail.com>
 <CAP-5=fV8GOLeHc8ZN_ddUPdWTCP2hykeApLZ80N9AwNzR+=LMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV8GOLeHc8ZN_ddUPdWTCP2hykeApLZ80N9AwNzR+=LMw@mail.gmail.com>

> On Mon, Feb 09, 2026 at 09:33:41AM -0800, Ian Rogers wrote:
>
> I did an update this morning but found I needed to install rustc to
> get the build working. I'm not sure things work without rustc
> installed as advertised.

Yeah, sorry for that. There are few fixes starting from 3f5dfa472ea
(tools build: Fix rust feature detection), which should address this.
