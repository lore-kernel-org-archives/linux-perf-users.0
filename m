Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CD3D566F
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490067; cv=pass; b=DVzbVg59Xxzb688Kbn03Z3pCzcg7+95MtGamJsOyqBuAVifwv/+YiwQinmrGhkFZVB0W+R6VjFBN8BQ5lsz5/gdFJ+lHtbg/Som4hn77Xs5UguPREdwFDIVRuNPf13gbJGSKSWSSENTIVxiluHE1QbiY1lcT6BOhPVnO7co3yQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490067; c=relaxed/simple;
	bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+QGpyt2gax3/1Gz8I7fI9hGKezwFM16vK92zPL9ToRXuDUsOVNbsdG2dARC0JnzZIy9WP8N/1lGpA3hHs2ZDPp64KblkrLFNDnIBi7Ak/w6qidhX7LbPOUHimqbJGvaoCuDa1DumXp13O6NWFjHkL0xsIw8LdqvsHlYmLIOZz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k38yx2/I; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k38yx2/I"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so30324657b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 06:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787490062; cv=none;
        d=google.com; s=arc-20260327;
        b=Qe03bMHHW1ygIGiHdQq1Wx2nNjKsARWdFZ7AU+P4Xkikw7r1IHwM6m+EP5Tpcmpm40
         HCgXaoQfZ3vWFqMrMQOaLH4ZNkRI0igcLAU6uhnsKSC1NGSEVQYLJP7BOTfJuCPdwC48
         s9w1sG4Xcg7jqUSomUgjvMZUKUtFUyLkQzPejj655JBML3dzG4egcoIA1t9b54uwuc1C
         zAOb0Zk0HjabTqIrPya9FD4qC8BgProOtuC/CfKIwJ1jEt/EkO/2sA+1sCZ/w0+Pr8Xz
         yD+IoraMB4npI+ejiO+NWCHUQxvUznCuc+pkDoH9rgSzrsq+w6LlXmUJ0d+yclIVG6qG
         CZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        fh=YL8VpKCmKnbVH/DWt8wMRH7UqFBWLAkQfjsYsEUnS28=;
        b=T6ZYhFTGU53hoTbARrAvB+KOt7nKdsKpexVglzXTtAOHm3kzfPj6H2wmXjophMQIW+
         SzuHlZq06SUIohh0dDhTrOAfLkh4Wx5LesA80t7UuKNQoDVOVyG/2D6GSMQpb3F3fYPy
         qn57gI9oNe8w9gu65DdqhiZy4iwqsO2/U1gFwYtOCZVBJ6CT/7aTQ3wqEFaG2GZte2T8
         gBV2XSr38I1lP9p3jK2n+JgItdw1OttS1OQ604uLgoE+xHBGODSbQF0GVfWOLQCo18/6
         phYZtMpVT0etb6QM0NFudku0ue9yj37Ae24fdwU5kh3IQ7DcwyapXRhlMbuy9dNE3aAe
         UNTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787490062; x=1788094862; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        b=k38yx2/IMBewZ5wPeY3wfArb828ZqSjceF37/VrS5Jhm+rXjZCoaZj1JHnVNF9Hxyp
         LtpfZXrV98VUQkK3TiWQUIOITohio6QLOWThlVRwdRUoZssb/1ODZKNEtgko7iQkZtP5
         0zF0cfDQfnUR2oQXbojj14e/mzFzAhy7D85twScxZlvwrQPrD/Xz+l2jycfbgDe0z7t6
         bK+9R562wiX/AQEB3ZqyI3k5tQ9DzQRgElGQ/VHdulr7KezzAIrRPvIE13rWD7gQ9p/N
         ORmLevWXRIPJmeQ0u5/zYPEriO3roaW6CLIb2bDtprUDlmxbr91djCOqE2FCnn2+w5ag
         qDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787490062; x=1788094862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        b=Uv9O4fRuV3eai+9LOaNARpMhEFWdIYlhhYxiZGClgBsgl3VJBoFpGxMN/5MDOz3ntW
         KxkfOYYXuuFnrlLy6KmuZQA40VFGDlmaJMYHT0loFqaF3O1ILhomwhPU79x6as52x255
         7sP5o9yQsVp6X7KljV487s4jRzDdYsZhvXDj4dBQ+Bxc36ojQY913EPdVU0zjKIi0QMW
         Pw6Bcg8J10TZ09VfMRUYWzu9xhFGnkX1BHwXdLqADH+LDiFbTUSw9hJMIGrL5qCO3DLW
         pQ3ESnqe3RxBqV39Dc0Nc8qKXUr3Yf1l1rgDFwn2jHBn4jkkYgI+BZohRXVNNNB9xNyT
         plDA==
X-Forwarded-Encrypted: i=1; AHgh+RrNVOIEeKP2sXaH0pYMz6tkosqpDTsmFUoGh7tVU0hasozZioUUSLcavih0wdo5ySp9e4pZQlBkNBN8uMLNsx77@vger.kernel.org
X-Gm-Message-State: AFuF++ny/wvYdNrJ2y/rbdHEClY3a3IHn97Osuu/9AY+gANr3iYIqUT3
	S9Itpg4oCFpNz+vVzD496vCiW8wMgqFem0oP9kgUmxz6D/vggX/XIF7XxGx11u9gUVjVLKHKz4J
	vmtRhD1TMsz7BRzFTSMNq8tWhuambWDl87o9n9U17BA==
X-Gm-Gg: AR+sD10HOk0xXesXQAVffsfJoDEB+YxvXHjvZQvfmccWXp4Ag9wGd9NV8FpLDcrJbG2
	kisFntTipujoxEUNT1GjeIjtQDWbSF8egdXMiX3CGj7X9Ki0fGGM4ikKDs2Mq/t8/ytABU6XFpr
	FIVW1tB6+Kod7NlfJFqDbkqImG3RtIIsZqOf9zPvYiU0ydP2VxPxBLM9HFbR1Akv478BRRkOqyQ
	C5xyTwWYp2t5X4Eue0E/KoImeN9uIgfQ6jNRWhcxEFUfeGVB/LAfE0jq4anSu7gzUh1rtqIWM6z
	Xn06nbn6jPMbOTWHzOPYmfhAL3yHmEjBCtjniqJvrBonWQ==
X-Received: by 2002:a05:690c:d83:b0:80c:cad:c4e5 with SMTP id
 00721157ae682-849f7ff26aemr72556687b3.30.1787490062386; Sun, 23 Aug 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <20260822060014.AD2681F000E9@smtp.kernel.org>
 <20260823210208.25e21677ac0c691037d7ef24@kernel.org>
In-Reply-To: <20260823210208.25e21677ac0c691037d7ef24@kernel.org>
From: Keke Ming <ming.jvle@gmail.com>
Date: Sun, 23 Aug 2026 21:00:51 +0800
X-Gm-Features: AcwNN1XIQy6WlLi80y3ZyXLQhI2zYm0ez-nOfVD-Q_nScJLYDeV9eVrRCcMmrdc
Message-ID: <CABbwK514OkuOk4E97a_45BkSKU35nsMAV0U1YqmoYOXEhysqKw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, agreed.

> Hmm, this seems another bug here.

I chose method 2 (clearing ri->extra_consumers when dup_return_instance())
in this patch set. Please let me know if you prefer the first approach instead.
