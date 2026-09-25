Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC64C8C50
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350675; cv=pass; b=ElppNVhM5fZX6lUWIUbvAZe1UbSqC3q7UmX8EJS7Ddz/gjUirTWDIzlwKK4yTi970lx4JJYoXFewzVJrXM9ZRs1TOcUlJMigSz5OzVtg66lFMSr82uOdz5lqIRzPsQDg3+Vlo7QO0tVGue3GfwPyqkYq+NPzb3fKmQZep4slhLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350675; c=relaxed/simple;
	bh=mKPQQujZxMNfUh0m5fG/9Me1zmKiPoB+4IPB+e75ce0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1jgNBPmCEBY4HKUAWrf6gw1CW2d/CBaGhF8OzDIzDszFRFrBVPTbGkWgsSSp0AT4uUbNGtUnG1Qgw5m0JEb7EEgdpS82TtrZcR99H/5aqeWE6661Kg3uykxoVR3pY+Q7ij/d4sOTf5+fbys2Zqh+AHfohy6jmtGC7IoTD+2O40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrXkCbzi; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrXkCbzi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-532e9ad9a1eso343911cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350672; cv=none;
        d=google.com; s=arc-20260327;
        b=GnXIzVBtPlH8Hs8EOeRioG+Ke1CwB/nFwy1WYgce64aAaIhSXgrsEGvd8fE15jwwFv
         KKrXfq56ERHw38UZ6o1zbNbPH5Lmq6IfveGH8S5oob9aLmluufkE6BNGmn9iHwGWLVez
         9YFXmuDhn6TSrj7xJ95mrvcgvFf2+omSDIzqeKviKnqXJe/4a2yXWaHEK/WIjwN1qx2i
         iAyzy1hFMbfELj6ymoT/T4TdhJ12xl+l+Ze0R3ZTAjBjOtdv+j02T/y8SfHca/bgCt29
         8nj5+hWf7F+u1brgph4UMF9IM/JBZ2LuPu5PqaA7Hj2Uz6FucO2eenQ2GVuCSwyY70mR
         a+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRZHv9paNXwOCV+6sSsc+HnzJsuWsikfddWiWitjUqw=;
        fh=WEqRKOurxYWQANlHjSxuhO5jnKbYzwZFrfZWIf8bo+Q=;
        b=nygDJrI8KOIF9eXnXkLPvYuk10kkrxlv0CwteA4s7IdzCVeCTHeNy2bO5PAOI8W+u9
         sqKpib70zEcBIjpQw+bXRg/Lc6/20/9LaQiCHUP+PZfIz0hBHE3Ao+8OSVHuo4kWtPrO
         9y37I6ebIZa19vgm4h7G29t5P9yKIsuP7W1dp1KibDyLEVJr5rOSFt0lw+2a+1hYvsLP
         zmWPhOXNjRto/IWQS/ozg+5NohEN6/rYHTFYbzn3nofyHnd4lhQw4fg2dGnBqpO7dJDz
         73svCnjbomsuDBJQGCE9sCkVr57X1NQIUXyuMseOtiCLsWqTOUh1QfC3Ar8bbnsV1+zf
         X7Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790350672; x=1790955472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRZHv9paNXwOCV+6sSsc+HnzJsuWsikfddWiWitjUqw=;
        b=vrXkCbziKUarU9/Jl1BRoGoM1ZwWCfT/QrowiWXle9CXJ7eyKRDLU8Mo7Jnc2SxInJ
         /b6T53i/SpX2wjIYU99YVS4OM7oVYmx4K9kHag+mhwhheQ8V5v6APuUIPeMbLDpceB0p
         FVA9XaMhuCdck+taPKELTpbe0P5LLOCSscl+ExhzNKaF5dr1atB8UD8LIiXVL8y1tOJ3
         chqD99H1+sldXrSkxledA4K6p42HUaNZofQZf4P1vijriOb2snv7eHhHg7GoSM5uYAgA
         pEzrxFketDWqBd+XjeNhuY/LGfxc/P9z4VZmBALwraoaHCrV157pb272YNjblGKeLhO6
         LYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350672; x=1790955472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRZHv9paNXwOCV+6sSsc+HnzJsuWsikfddWiWitjUqw=;
        b=QCQP4VkpHuGpOdSdBN9yy9Jpe0JfROpKON0XXj0jqcSwRGDZfbRKkYvIMmwZbtrqKY
         fTjUFqq33IebK4zgjm+awhsznUTkjeQSWveZPrnMEhYCxDp40hINSip06Rki4AxtTuv8
         Nsu0aZkSwhpS05uQkywIzcaEPyy3L+if0bNKWLEk0hquxZVq2rtxFtIgRjGzpampiq/I
         y2me81wFyh8xtVzDhbEwSMyI5CRT3o7jOE7snVCc39jvUNd0McePNRW+TiFnkCtIU0h1
         BUShqL2Vf6kvR4f0NtZZVt7Ix30pE1AFavOjemGD8T5Pj+WQouNzhd47m14A0Uzi7SvO
         pw+A==
X-Forwarded-Encrypted: i=1; AKwUvBxaBQLrXaZR9EVX/ekslDohLJnUYyD7ctshFKtxmtQLFFO2hQuKDKz9E4M24pBJHoZ4MANY80a8JDDjb5nLWS3m@vger.kernel.org
X-Gm-Message-State: AFuF++lA9MBsIQoNyXIRPPv48JfXKDTojn2fTP3ilsSnBEUyYHEGQlpE
	Kl8xlnpYs/AumxWPtvIODQdUAjLfCqGjxRNC75a6eaumt7xp6f+fhbZG7csgMM9DrYqlKWbevhT
	5wm0YC/rF3NrixXyiuwTp2AHEd5iOF7Feqp+UR0Ul
X-Gm-Gg: AYBFou0jEeQyunD6W+1EY7ixk5HEJ9PRZmPlnWaHkSzAM31E/bAWRtj6ZA3U5K715/Y
	BgFAe+p3JOmPKrDQE/1tvXhGr3utWhWR0+HSJyEenP8Luq5yZKcdbIovVKSz8CTP7RwpryHJe4C
	aCIcxQcfzxpsFTWlMdKS+bqlQ6UNZEKoSiwp+SJhiFiGdqgHJDQt3PxpRVdmDctOlvH1qpdp4yZ
	QILEja/DGyANhJIoGNEEOmG9KWL4E7JIoUQsDp85qyTFx43mm3w38V3ViJ1f73IeSW3iNS4zh64
	5DRnnbVAY6LPlCPeJyGP4ptTBNp7R6BHG0PoAtABhhufSRajak8SGBIC+/2jwkKG/4O9Iq5imYX
	CtyTUTkXwM1I=
X-Received: by 2002:a05:622a:310:b0:532:d72d:3e9c with SMTP id
 d75a77b69052e-5331a7c270cmr3451761cf.6.1790350670909; Fri, 25 Sep 2026
 08:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925150657.1826942-1-acme@kernel.org> <20260925150657.1826942-5-acme@kernel.org>
In-Reply-To: <20260925150657.1826942-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:37:39 -0700
X-Gm-Features: AclHuK_rcMejODDQ1Icc7aDakCpLrkuQwxU-ufilDnYr9qtqZfMuP9kDEQauYJg
Message-ID: <CAP-5=fVAekxsEGy91FHXsHmvpCyx48q-8UetLJ2B7cU8sYRaUg@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf annotate-data: Bound the member nesting recursion
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Members are added recursively, and a broken DIE can make a member's
> type point back at one of its own ancestors, recursing until the stack
> is gone; nothing usable comes out of nesting members 32 deep anyway, so
> stop there, marking the member as truncated and giving up on member
> types that don't resolve.
>
> The check is where the children of an aggregate would be expanded, so
> only struct/union members are marked as truncated.
>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.c | 20 ++++++++++++++++++--
>  tools/perf/util/annotate-data.h |  3 +++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index bc9698abc6a9e055..19a6ecd67f28719d 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -222,6 +222,12 @@ static bool data_type_less(struct rb_node *node_a, c=
onst struct rb_node *node_b)
>         return strcmp(a->self.type_name, b->self.type_name) < 0;
>  }
>
> +/*
> + * A broken type can point back at one of its own ancestors: bound the
> + * nesting so it doesn't recurse until the stack is gone.
> + */
> +#define MAX_MEMBER_DEPTH 32
> +
>  /* Recursively add new members for struct/union */
>  static int __add_member_cb(Dwarf_Die *die, void *arg)
>  {
> @@ -236,6 +242,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>         if (dwarf_tag(die) !=3D DW_TAG_member)
>                 return DIE_FIND_CB_SIBLING;
>
> +       if (die_get_real_type(die, &die_mem) =3D=3D NULL)
> +               return DIE_FIND_CB_SIBLING;
> +
>         member =3D zalloc(sizeof(*member));
>         if (member =3D=3D NULL)
>                 return DIE_FIND_CB_END;
> @@ -248,8 +257,6 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>         if (die_get_typename(die, &sb) < 0)
>                 strbuf_add(&sb, "(unknown type)", 14);
>
> -       die_get_real_type(die, &die_mem);
> -
>         if (dwarf_aggregate_size(&die_mem, &size) < 0 || size =3D=3D 0) {
>                 if (dwarf_tag(&die_mem) =3D=3D DW_TAG_array_type) { /* fl=
ex-array? */
>                         die_get_real_type(&die_mem, &die_mem);
> @@ -299,6 +306,7 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>         }
>         member->size =3D size;
>         member->offset =3D loc + parent->offset;
> +       member->depth =3D parent->depth + 1;
>         INIT_LIST_HEAD(&member->children);
>
>         list_for_each_entry_reverse(prev, &parent->children, node) {
> @@ -313,6 +321,14 @@ static int __add_member_cb(Dwarf_Die *die, void *arg=
)
>                 member->is_union =3D true;
>                 /* fall through */
>         case DW_TAG_structure_type:
> +               /* Only aggregates have children to expand, so only they =
get truncated. */
> +               if (member->depth >=3D MAX_MEMBER_DEPTH) {
> +                       /* Consumed by the JSON exporter added in a later=
 series. */
> +                       member->truncated =3D true;
> +                       pr_debug_dtp("member nesting limit reached at %s\=
n",
> +                                    member->type_name ?: "(unknown type)=
");
> +                       break;
> +               }
>                 die_find_child(&die_mem, __add_member_cb, member, &die_me=
m);
>                 break;
>         default:
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 14b8113521a927cf..ca0abfb2a036d229 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -61,6 +61,9 @@ struct annotated_member {
>         int size;
>         bool is_union;
>         bool is_flex_array;
> +       unsigned int depth;
> +       /* Children not expanded because the nesting limit was reached */
> +       bool truncated;
>  };
>
>  /**
> --
> 2.53.0
>
