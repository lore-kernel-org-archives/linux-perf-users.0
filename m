Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85AC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 20:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCTUsy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCTUsx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 16:48:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6693AF0F
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 13:48:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ddbf70d790so327611cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679345330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iGj9gwcm4e4ac0NCSGO8171w0NDeoSnjyBfeexxjTo=;
        b=GomZIKXsD6iYzuOydfHF7Vmd+/a2V5ldYR8Nc+H906JlSAkGrNW/aCrrn+jWPH74l4
         le8ZJDTPI7d/OrLg4BFEvdt0iaTeKN6e/CNnty2h8rW7sDWYKk5GmN8DoP7epXQZjKGd
         zBDqInSq3D5KL/4+eAMvClcwKo3onL3m9rUG1sIjrlPgiK107rc4QOInKrcqsP0+K2Sm
         Iwgvo3iKQcW9TxKp/QFo39S9YtxuWk8YWLjkzBXOTTu+A9tC4Gk21hzAYyF8Taqv63EP
         Nu5+dt9F1klOu6rBl+WSli0l8vnlqABd5wePDZ2s5jmer9uD9f462wVG/hOsBzXuAzGu
         FU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iGj9gwcm4e4ac0NCSGO8171w0NDeoSnjyBfeexxjTo=;
        b=IcK/j339z0NtydznjlpT+/KeIcNrnxq1P7ZqcsHAwNJ/hm0KcPRpWwHD+lXHMdHaS8
         rOuzm5fBFi6SCqALmkZ5dsIM9bWRp51qD9cr3aMxXJcNzffW4DXcSyVbkyozI7EXVl9G
         vut50P2b5DVIomwlmAYz8Zsd22+yIOY5wZ2x/W7zUyBXuQBcdRaeuBaldZzh0DWDAYEl
         b4nkfTVxf3NnNQ9pq+Qr+q/nHRSFPeqXp2SPg0pnTwg9mhtvt6/M9zdRnMKuhQhezyCU
         NRyBhLnzBA/N2Y/8dXI6iqz/zGF4SrV/QbW47xtNXUDoY/S0SoGilyU/EgZP2Sriq2qF
         6CYQ==
X-Gm-Message-State: AO0yUKX69dXOh/smAUDCkoO/bk50k0rB8x7mz+/RjeahDeK2+NTfz1lD
        mcf9Us21ihzPmFMsHx7hmp5pbYv0463Cs5RwAxHQBNxaPcPDvsYy/qjN7w==
X-Google-Smtp-Source: AK7set/G9GbTxjCo4Pwsbe2Elo0X85937zZME0lUs/FSvigtRHGSnx6jYbVWcur4ZREWNa4Zz4O32o9PXllUVNM0u0o=
X-Received: by 2002:a05:622a:170f:b0:3b9:f696:c759 with SMTP id
 h15-20020a05622a170f00b003b9f696c759mr132455qtk.10.1679345329601; Mon, 20 Mar
 2023 13:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230320201841.1133-1-bwiedemann@suse.de>
In-Reply-To: <20230320201841.1133-1-bwiedemann@suse.de>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 13:48:38 -0700
Message-ID: <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Sort list of input files
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        Ben Hutchings <benh@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 20, 2023 at 1:19=E2=80=AFPM Bernhard M. Wiedemann
<bwiedemann@suse.de> wrote:
>
> Without this, pmu-events.c would be generated with variations in ordering
> depending on non-deterministic filesystem readdir order.
>
> I tested that pmu-events.c still has the same number of lines
> and that perf list output works.
>
> This patch was done while working on reproducible builds for openSUSE,
> but also solves issues in Debian [1] and other distributions.
>
> [1] https://tests.reproducible-builds.org/debian/rb-pkg/unstable/i386/lin=
ux.html
>
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> CC: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Thanks Bernhard,

I think this may already be addressed by sorting prior to output:
https://lore.kernel.org/r/20220812230949.683239-5-irogers@google.com

Could you confirm?

Thanks,
Ian

>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 2bcd07ce609f..f06e1abac7c7 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -381,10 +381,13 @@ def read_json_events(path: str, topic: str) -> Sequ=
ence[JsonEvent]:
>
>    return events
>
> +def sorted_scandir(path: str) -> list[os.DirEntry]:
> +  return sorted(os.scandir(path), key=3Dlambda e: e.name)
> +
>  def preprocess_arch_std_files(archpath: str) -> None:
>    """Read in all architecture standard events."""
>    global _arch_std_events
> -  for item in os.scandir(archpath):
> +  for item in sorted_scandir(archpath):
>      if item.is_file() and item.name.endswith('.json'):
>        for event in read_json_events(item.path, topic=3D''):
>          if event.name:
> @@ -497,7 +500,7 @@ def preprocess_one_file(parents: Sequence[str], item:=
 os.DirEntry) -> None:
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
>    def is_leaf_dir(path: str) -> bool:
> -    for item in os.scandir(path):
> +    for item in sorted_scandir(path):
>        if item.is_dir():
>          return False
>      return True
> @@ -889,7 +892,7 @@ def main() -> None:
>    def ftw(path: str, parents: Sequence[str],
>            action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
>      """Replicate the directory/file walking behavior of C's file tree wa=
lk."""
> -    for item in os.scandir(path):
> +    for item in sorted_scandir(path):
>        if _args.model !=3D 'all' and item.is_dir():
>          # Check if the model matches one in _args.model.
>          if len(parents) =3D=3D _args.model.split(',')[0].count('/'):
> @@ -930,7 +933,7 @@ struct compact_pmu_event {
>
>  """)
>    archs =3D []
> -  for item in os.scandir(_args.starting_dir):
> +  for item in sorted_scandir(_args.starting_dir):
>      if not item.is_dir():
>        continue
>      if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.na=
me =3D=3D 'test':
> --
> 2.35.3
>
