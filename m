From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: add newline after uregs output
Date: Wed, 7 Nov 2018 11:25:41 -0300
Message-ID: <20181107142541.GD18346@kernel.org>
References: <20181107093705.16346-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107093705.16346-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Nov 07, 2018 at 10:37:05AM +0100, Milian Wolff escreveu:
> This change makes it much easier to easily distinguish
> between consecutive samples by keeping the empty line
> between them, like we see when we do not enable uregs
> output.

Thanks, applied.

- Arnaldo
